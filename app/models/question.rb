class Question
  include Mongoid::Document




  def self.all

    # standard variants
    yesNo = [
      {code: 'yes', text: 'Yes'},
      {code: 'no', text: 'No'}
    ]

    yesNoUnknown = [
      {code: 'yes', text: 'Yes'},
      {code: 'no', text: 'No'},
      {code: 'unknown', text: "Don't know"}
    ]

    [
   

      {
          code: 'confidentiality',
          text: "We will start with some personal details and then move on to health questions.  Your answers are confidential and will form part of your anaesthetic records at the hospital.",
          desc: 'Confidentiality statement',
          group: "Confidentiality",
          type: 'confirm_statement'
      },



      {
        code: 'last-name',
        text: 'Family name',
        desc: 'Surname',
        group: "Personal"
      },

      {
        code: 'first-name',
        text: 'First name',
        desc: 'Forename',
        group: "Personal"
        },
      {
        code: 'dob',
        text: 'Date of birth (Year - Month - Day)',
        desc: 'DOB',
        type: 'date',
        group: "Personal",
        calculate: {age: "age"}
      },
      {
        code: 'gender',
        text: 'Gender',
        desc: "Gender",
        group: "Personal",
        variants: [
          {code: 'm', text: 'Male'},
          {code: 'f', text: 'Female'}
        ]
      },
      {
        code: 'preferred-telephone-contact',
        text: 'Your doctor may need to speak to you prior to your day of surgery.  Which is the best telephone number to contact you?',
        desc: "Preferred contact",
        group: "Contacts",
        variants: [
          {code: 'work', text: 'Work'},
          {code: 'home', text: 'Home'},
          {code: 'mobile', text: 'Mobile'}
        ]
      },
      {
        code: 'home-phone',
        text: 'Home telephone',
        desc: 'Home telephone',
        group: "Contacts",
        require: {'preferred-telephone-contact' => '=== "home"'}
      },
      {

        code: 'work-phone',
        text: 'Work telephone',
        desc: "Work telephone",
        group: "Contacts",
        require:{'preferred-telephone-contact' => '=== "work"'}
      },


      {
        code: 'mobile-phone',
        text: 'Mobile telephone',
        desc: "Mobile telephone",
        group: "Contacts",
        },

      {
        code: 'sms-message',
        text: 'Are you happy to receive text messages (SMS) on this phone from your doctor?',
        group: "Contacts",
        variants: yesNo,
        desc: 'SMS consent'
      },

      {
        code: 'parent-name',
        text: 'Parent name',
        require: {age: '< 18'},
        group: "Contacts",
        desc: 'Parent name'
      },
      {
        code: 'parent-contacts-same-as-patient',
        text: "Are the contact details for the parent the same as the patient's contact details?",
        variants: yesNo,
        group: "Contacts",
        require: {age: '< 18'},
        desc: 'Parent contact details same'

      },

      {
        code: 'parent-preferred-telephone-contact',
        text: 'Which is the best telephone number to contact the parent?',
        variants: [
          {code: 'contact-parent-at-work', text: 'Work'},
          {code: 'contact-parent-at-home', text: 'Home'},
          {code: 'contact-parent-at-mobile', text: 'Mobile'}
          ],
        desc: 'Parent preferred contact',
        group: "Contacts",
        require: {
          age: '< 18',
          'parent-contacts-same-as-patient' => '=== "no"'
        }
      },



      {
        code: 'parent-home-phone',
        text: 'Parent home telephone',
        desc: 'Parent home',
        group: "Contacts",
        require:
        {
          age: '< 18',
          'parent-contacts-same-as-patient' => '=== "no"',
          'parent-preferred-telephone-contact' => '=== "contact-parent-at-home"'

        }
      },


      {
        code: 'parent-work-phone',
        text: 'Parent work telephone',
        desc: 'Parent work',
        group: "Contacts",
        require:
        {
          age: '< 18',
          'parent-contacts-same-as-patient' => '=== "no"',
          'parent-preferred-telephone-contact' => '=== "contact-parent-at-work"'

        }
      },

      {
        code: 'parent-mobile-phone',
        text: 'Parent mobile telephone',
        desc: 'Parent mobile',
        group: "Contacts",
        require:
        {
          age: '< 18',
          'parent-contacts-same-as-patient' => '=== "no"',
           'parent-preferred-telephone-contact' => '=== "contact-parent-at-mobile"'
        }
      },

      {
        code: 'referring-surgeon',
        group: "Procedure",
        text: 'Who is your surgeon or doctor performing the procedure?',
        desc: 'Surgeon'
      },



      {
        code: 'surgical-procedure-planned-patient-reported',
        group: "Procedure",
        text: 'What operation or procedure are you having?',
        desc: 'Procedure'
      },




      {
        code: 'surgical-diagnosis-patient-reported',
        group: "Procedure",
        text: 'What is the reason for having this procedure or operation?',
        desc: 'Indication'
      },



      {
        code: 'procedure-date-patient-reported',
        group: "Procedure",
        type: 'date',
        text: 'What is the planned procedure date? (Year - Month - Day)',
        desc: 'Procedure date'
      },



      {
        code: 'start-of-health-information',
        text: "The following questions are about your general health including surgical history and medicines that you take.",
        group: "General Health",
        type: 'statement'
      },


      {
        code: 'surgery-previous',
        text: "Have you had surgery before?",
        desc: 'Previous surgery',
        group: "Surgical",
        variants: yesNo
      },
      {
        code: 'surgery-previous-list',
        text: "Briefly, what operations have you had?",
        desc: 'Previous procedures',
        type: 'text',
        group: "Surgical",
        require: {'surgery-previous' => '=== "yes"'}
      },
      {
        code: 'anesthetic-complications-previous',
        text: "Have you had any problems or concerns with your previous anaesthetics?",
        desc: 'Anaesthetic issues',
        variants: yesNo,
        group: "Surgical",
        require: {'surgery-previous' => '=== "yes"'}
      },


    {
      code: 'anaesthetic-complications-previous-details',
      text: "Please describe the problems you've had.",
      desc: 'Anaesthetic issues description',
      type: 'text',
      group: "Surgical",
      require:
        {
        'anesthetic-complications-previous' => '=== "yes"',
        }
     },

      {
        code: 'anesthetic-complications-family-history',
        text: "Have any of your relatives had problems with anaesthetics?",
        desc: 'Family history anaesthetic issues',
        variants: yesNoUnknown,
        group: "Surgical",
        require: {'surgery-previous' => '=== "no"'}
      },

      {
      code: 'anesthetic-complications-family-history',
      text: "Please describe the problems they had.",
      desc: 'Anaesthetic family history description',
      type: 'text',
      group: "Surgical",
      require:
        {
        'anesthetic-complications-family-history' => '=== "yes"',
        }
     },
      {
        code: 'ponv-previous',
        text: "Have you had nausea or vomiting after anaesthesia?",
        desc: 'PONV',
        variants: yesNo,
        group: "Surgical",
        require: {'surgery-previous' => '=== "yes"'}
      },

    {
      code: 'history-of-difficult-intubation',
      text: "Has an anaesthetist ever told you that that it is difficult to put a tube in your windpipe or that you have a difficult airway?",
      desc: 'History of difficult intubation',
      group: "Surgical",
      variants: yesNo,
      require: {'surgery-previous' => '=== "yes"'}
    },

    {
      code: 'history-of-difficult-intubation-details',
      text: "Please provide some information.",
      desc: 'Difficult airway details',
      group: "Surgical",
      type: 'text',

      require:
        {
        'history-of-difficult-intubation' => '=== "yes"',
        }
     },


      {
        code: 'medication',
        text: "Do you take any medicines (including tablets, inhalers, patches or creams)?",
        desc: 'Medication',
        group: "Medications",
        variants: yesNo
      },
      {
        code: 'medication-list-current',
        text: "Please list all medicines, including dose and frequency.",
        desc: 'Medication list',
        type: 'text',
        group: "Medications",
        require: {'medication' => '=== "yes"'}
      },
      {
        code: 'allergies',
        text: "Do you have any allergies (including medicines, latex rubber, tapes or food)?",
        desc: 'Allergies',
        group: "Medications",
        variants: yesNo
      },
      {
        code: 'allergy-cause-reaction',
        text: "What are you allergic to?  What happens when you have it?",
        desc: 'Allergy and reaction',
        type: 'text',
        group: "Medications",
        require: {allergies: '=== "yes"'}
      },
      {
        code: 'drug-side-effects',
        text: "Are there medicines you can't take because of side effects?",
        desc: 'Side effects',
        group: "Medications",
        variants: yesNoUnknown
      },

          {
      code: 'drug-side-effects-details',
      text: "Please provide some information about these side effects.",
      desc: 'Side effects details',
      group: "Medications",
      type: 'text',

      require:
        {
        'drug-side-effects' => '=== "yes"',
        }
     },
      {
        code: 'height-patient-report-cm',
        text: "How tall are you (in centimeters)?",
        desc: 'Height (pt report)',
        group: "General Health",
        require: {age: '> 12'}
      },
      {
        code: 'weight-patient-report-kg',
        text: "How much do you weigh (in kilograms)?",
        desc: 'Weight (pt report)',
        group: "General Health"
      },


      {
        code: 'exercise-tolerance-METS',
        text: "I need to understand how much exercise you can do. Tick all the activites that you can do.",
        desc: 'Exercise tolerance',
        group: "General Health",
        type: 'checklist',
        variants: [
          {code: '1-2 METS', text: "Sit quietly in a chair"},
          {code: '2-2.3 METS', text: "Dress, iron, stand for 2 hours, play cards"},
          {code: '3-5 METS', text: "Make a bed, mop floors, handwash clothes, walk 4km/h, bowl"},
          {code: '4.5-5.2 METS', text: "Walk down a flight of stairs"},
          {code: '5-6 METS', text: "Carry a light parcel up stairs without stopping, garden, rake weed, roller skate, dance a fox trot, walk 6km/h on level ground"},
          {code: '7-9 METS', text: "Carry 10kg up 8 steps, shovel soil, carry 35kg objects, jog 8km/h, play football, squash or skiing"}
        ],
        require: {age: '> 10'}

      },


      {
        code: 'carer-for-ADLs',
        text: "Do you usually have a carer that helps you with activities like eating and washing?",
        desc: 'Carer for ADLs',
        group: "General Health",
        variants: yesNo,
        require: {age: '> 10'}
      },

      {
        code: 'alcohol-current',
        text: "Do you drink alcohol?",
        desc: 'Alcohol',
        variants: yesNo,
        group: "General Health",
        require: {age: '> 14'}
      },
      {
        code: 'alcohol-units-per-week',
        text: "How many standard drinks would you have a week?",
        desc: 'Alcohol units/week',
        type: 'number',
        group: "General Health",
        require: {'alcohol-current' => '=== "yes"'}
      },

      {
        code: 'tobacco-ever',
        text: "Have you ever been a smoker?",
        desc: 'Tobacco ever',
        group: "General Health",
        variants: yesNo,
        require: {age: '> 14'}
      },

    {
      code: 'tobacco-current',
      text: "Do you smoke now?",
      desc: 'Current smoker',
      group: "General Health",
      variants: yesNo,
      require:
        {
        'tobacco-ever' => '=== "yes"'
        }
     },

     {
      code: 'tobacco-cigarettes-per-day',
      text: "On average, how many cigarettes do you smoke each day?",
      desc: 'Cigarettes/day',
      group: "General Health",
      require:
        {
        'tobacco-current' => '=== "yes"',
        }
     },


    {
      code: 'tobacco-date-stopped',
      text: "Approximately, when did you stop?",
      desc: 'Stopped smoking',
      group: "General Health",
      require:
        {
        'tobacco-current' => '=== "no"',
        }
     },


     {
      code: 'illicit-drugs',
      text: "Do you take any recreational drugs?",
      desc: 'Illicit drugs',
      group: "General Health",
      variants: yesNo,
      require: {age: '> 14'}
     },

     {
      code: 'blood-product-limitation',
      text: "If a blood transfusion was required, is there any reason you could not have blood?",
      desc: 'Limitation to blood products',
      group: "General Health",
      variants: yesNo,

     },


     {
      code: 'limitation-to-blood-reason',
      text: "What limitations are there?",
      desc: 'Reason for limiation to blood products',
      type: 'text',
      group: "General Health",
      require:
        {
        'blood-product-limitation' => '=== "yes"'
        }
     },


     {
        code: 'cognitive-impairment',
        text: "Have you been diagnosed with any developmental problem or delay?",
        variants: yesNo,
        group: "Paediatric",
        desc: "Cognitive impairment",
        require: {age: '< 14'}
      },


      {
        code: 'congenital-or-hereditary-disease',
        text: "Do you have a diagnosis of hereditary disease or disease from birth?",
        variants: yesNo,
        desc: "Congenital or hereditary disease",
        group: "Paediatric",
        require: {age: '< 14'}
      },


     {
      code: 'congenital-or-hereditary-disease-details',
      text: "Please describe?",
      desc: 'Congenital or hereditary disease',
      group: "Paediatric",
      type: 'text',
      require:
        {
        'congenital-or-hereditary-disease' => '=== "yes"'
        }
     },


      {
        code: 'wheeze',
        text: "Do you have a history of wheezing or asthma?",
        desc: "Wheeze or asthma",
        group: "Paediatric",
        variants: yesNoUnknown,
        require: {age: '< 14'}
      },


     {
      code: 'premature-delivery',
      text: "Were you born prematurely?",
      desc: 'Premature delivery',
      group: "Paediatric",
      variants: yesNo,
      require: {age: '< 4'}
     },

    {
      code: 'hypertension',
      text: "Do you have high blood pressure or are you on treatment for high blood pressure?",
      desc: 'Hypertension',
      group: "Cardiovascular",
      variants: yesNo,
      require:  {age: '>16'}
     },

     {
      code: 'ischemic-heart-disease',
      text: "Have you ever had angina or a heart attack?",
      desc: 'IHD',
      group: "Cardiovascular",
      variants: yesNo,
      require:
        {age: '>16' }
     },


     {
      code: 'angina',
      text: "Do you still get angina?",
      desc: 'Angina',
      group: "Cardiovascular",
      variants: yesNo,
      require:
        {
        'ischemic-heart-disease' => '=== "yes"'
        }
     },

     {
      code: 'mi-ever',
      text: "Have you ever been diagnosed with a heart attack?",
      desc: 'MI',
      group: "Cardiovascular",
      variants: yesNo,
      require:
        {
        'ischemic-heart-disease' => '=== "yes"'
        }
     },


    {
      code: 'heart-failure',
      text: "Have you ever been diagnosed with heart failure?",
      desc: 'Heart failure',
      group: "Cardiovascular",
      variants: yesNo,
      require:
      {age: '>16' }
     },

    {
      code: 'history-of-arrhythmia',
      text: "Have you ever had an irregular pulse, arrhythmia or fibrillation?",
      desc: 'Arrhythmia',
      group: "Cardiovascular",
      variants: yesNo,
      require:
      {age: '>16' }
     },


    {
      code: 'atrial-fibrillation',
      text: "Have you had atrial fibrillation?",
      desc: 'Atrial fibrillation',
      group: "Cardiovascular",
      variants: yesNo,
      require:
        {
        'history-of-arrhythmia' => '=== "yes"'
        }
      },

    {
      code: 'arrhythmia-other',
      text: "What problems have you had with your heart rhythm?",
      desc: 'Arrhythmia details',
      group: "Cardiovascular",
      type: 'text',
      require:
        {
        'history-of-arrhythmia' => '=== "yes"',
        'atrial-fibrillation' => '=== "no"'
        }
     },
      {
      code: 'valvular-heart-disease',
      text: "Have you ever had heart valve problems, heart murmurs or infections?",
      desc: 'Valvular heart disease',
      group: "Cardiovascular",
      variants: yesNo,
      require:
      {age: '>16' }
      },

    {
      code: 'valvular-heart-disease-details',
      text: "What problems have you had with your heart valves?",
      desc: 'Valvular disease details',
      group: "Cardiovascular",
      type: 'text',

      require:
        {
        'valvular-heart-disease' => '=== "yes"',
        }
     },

      {
      code: 'pacemaker-or-icd',
      text: "Do you have a pacemaker or defibrillator?",
      desc: 'Pacemaker / ICD',
      group: "Cardiovascular",
      variants: yesNo,
      require:
      {age: '>16' }
      },
      {
      code: 'deep-venous-thrombosis',
      text: "Have you ever had a DVT or clot in the leg veins?",
      desc: 'DVT',
      group: "Cardiovascular",
      variants: yesNo,
      require:
      {age: '>16' }
      },

    {
      code: 'pulmonary-embolism',
      text: "Have you ever had a pulmonary embolism (PE) - clot in the lungs?",
      desc: 'Pulmonary embolism',
      group: "Cardiovascular",
      variants: yesNo,
      require:
        {
        'deep-venous-thrombosis' => '=== "yes"',
        }
     },
     {
      code: 'congenital-heart-disease',
      text: "Were you born with any heart disease?",
      desc: 'Congenital heart disease',
      group: "Cardiovascular",
      variants: yesNo
     },

      {
        code: 'copd',
        text: "Have you been diagnosed with emphysema or chronic bronchitis?",
        variants: yesNo,
        group: "Respiratory",
        require: {age: '> 13'}
      },

      {
        code: 'home-oxygen',
        text: "Are you on oxygen at home?",
        variants: yesNo,
        group: "Respiratory",
        require: {'copd' => '=== "yes"' }
      },
      {
        code: 'asthma',
        text: "Do you have asthma?",
        variants: yesNo,
        group: "Respiratory",
        require: {age: '> 13'}
      },
      {
        code: 'asthma-er-attendance',
        text: "Have you been to the hospital emergency room because of asthma?",
        variants: yesNo,
        group: "Respiratory",
        require_any_of: {
          'asthma' => '=== "yes"',
          'wheeze' => '=== "yes"'
        }
      },
      {
        code: 'asthma-hospitalisation',
        text: "Have you been admitted to hospital because of asthma?",
        variants: yesNo,
        group: "Respiratory",
        require_any_of: {
          'asthma' => '=== "yes"',
          'wheeze' => '=== "yes"'
        }
      },

      {
        code: 'asthma-reliever-frequency-weekly',
        text: "How many times a week do you use a reliever for asthma?",
        desc: 'Reliever per week',
        group: "Respiratory",
        require_any_of:
        {
        'asthma' => '=== "yes"',
        'wheeze' => '=== "yes"'
        }
      },
     {
       code: 'asthma-aspirin-sensitive',
       text: "Does your asthma get worse with aspirin or antiinflammatory medications?",
       desc: 'Aspirin sensitive asthma',
       group: "Respiratory",
       variants: yesNo,
        require:
        {
        'asthma' => '=== "yes"'
        }
      },

    {
      code: 'snorer',
      text: "Do you snore?",
      desc: 'Snorer',
      group: "Respiratory",
      variants: yesNoUnknown
     },
    {
      code: 'obstructive-sleep-apnoea',
      text: "Have you been diagnosed with sleep apnoea?",
      desc: 'Obstructive sleep apnoea',
      group: "Respiratory",
      variants: yesNo
     },

    {
      code: 'cpap',
      text: "Do you use a CPAP machine?",
      desc: 'CPAP',
      group: "Respiratory",
      variants: yesNo,
      require:
        {
        'obstructive-sleep-apnoea' => '=== "yes"',
        age: '> 12'
        }
     },

    {
      code: 'stop-s',
      text: "Do you snore loudly (louder than talking or loud enough to be heard through closed doors)?",
      desc: 'STOP S',
      group: "Respiratory",
      variants: yesNo,
      require:
        {
        'obstructive-sleep-apnoea' => '=== "no"',
        'snorer' => '=== "yes"',
        age: '> 12'
        }
     },
    {
      code: 'stop-t',
      text: "Do you often feel tired, fatigued, or sleepy during daytime?",
      desc: 'STOP T',
      group: "Respiratory",
      variants: yesNo,
      require:
        {
        'obstructive-sleep-apnoea' => '=== "no"',
        'snorer' => '=== "yes"',
        age: '> 12'
        }
     },
    {
      code: 'stop-o',
      text: "Has anyone observed you stop breathing during your sleep?",
      desc: 'STOP O',
      group: "Respiratory",
      variants: yesNo,
      require:
        {
        'obstructive-sleep-apnoea' => '=== "no"',
        'snorer' => '=== "yes"',
        age: '> 12'
        }
     },

    {
      code: 'recent-urti',
      text: "Have you had a cold, flu or upper respiratory infection in the last 6 weeks?",
      desc: 'Recent URTI',
      group: "Respiratory",
      variants: yesNo,
     },
     {
      code: 'cerebrovascular-accident',
      text: "Have you ever had a stroke, mini stroke or TIA?",
      desc: 'CVA/TIA',
      group: "Neurological",
      require:
        {
        age: '> 18',
        },
      variants: yesNo,
     },
     {
      code: 'seizure-disorder',
      text: "Have you ever had seizures or epilepsy?",
      desc: 'Seizure disorder',
      group: "Neurological",
      variants: yesNo,
     },

    {
      code: 'psychiatric-disorder',
      text: "Have you had depression, anxiety, phobias, schizophrenia or any other emotional or psychiatric problems?",
      desc: 'Psychiatric disorders',
      group: "Neurological",
      variants: yesNo,
      require: { age: '> 14'}
     },

    {
      code: 'psychiatric-details',
      text: "Please provide some brief information about these problems",
      desc: 'Psychiatric details',
      group: "Neurological",
      type: 'text',

      require:
        {
        'psychiatric-disorder' => '=== "yes"',
        }
     },

    {
      code: 'neuromuscular-disease',
      text: "Do you have any muscle or movement problems?",
      desc: 'Neuromuscular disease',
      group: "Neurological",
      variants: yesNo,
      require:
        {
        age: '< 14'
        }

     },


    {
      code: 'neuromuscular-disease-details',
      text: "Please describe these problems.",
      desc: 'Neuromuscular details',
      group: "Neurological",
      type: 'text',

      require:
        {
        'neuromuscular-disease' => '=== "yes"',
        }
     },

     {
      code: 'heartburn-reflux',
      text: "Do you have any heartburn, reflux or hiatus hernia?",
      desc: 'Heartburn Reflux',
      group: "Gastrointestinal",
      variants: yesNoUnknown

     },

    {
      code: 'peptic-ulcer-disease',
      text: "Have you been diagnosed with stomach ulcers or peptic ulcers?",
      desc: 'Peptic Ulcer Disease',
      group: "Gastrointestinal",
      variants: yesNoUnknown,
      require: { age: '> 14'}
     },
     {
      code: 'liver-disease',
      text: "Do you have any liver disease?",
      desc: 'Liver disease',
      group: "Gastrointestinal",
      variants: yesNo,
     },

    {
      code: 'hepatitis-ever',
      text: "Have you ever had hepatitis?",
      desc: 'Hepatitis',
      group: "Gastrointestinal",
      variants: yesNoUnknown,
      require:
        {
        'liver-disease' => '=== "yes"'
        }
     },

    {
      code: 'hepatitis-details',
      text: "Please provide some information about your hepatitis",
      desc: 'Hepatitis details',
      group: "Gastrointestinal",
      type: 'text',
      require:
        {
        'hepatitis-ever' => '=== "yes"',
        }
     },
    {
      code: 'cirrhosis',
      text: "Have you ever been diagnosed with cirrhosis?",
      desc: 'Cirrhosis',
      group: "Gastrointestinal",
      variants: yesNo,
      require:
        {
        'liver-disease' => '=== "yes"'
        }
     },
    {
      code: 'diabetes',
      text: "Do you have diabetes?",
      desc: 'Diabetes',
      group: "Endocrine",
      variants: yesNoUnknown,
    },
    {
      code: 'diabetes-treatment',
      text: "What do you use to treat your diabetes?",
      desc: 'Diabetes treatment',
      group: "Endocrine",
      type: 'checklist',
      variants:
        [
        {code: 'no-treatment', text: 'Nothing'},
        {code: 'diet-controlled', text: 'Diet'},
        {code: 'oral-hypoglycaemics', text: 'Tablets'},
        {code: 'insulin', text: 'Insulin'}
        ],
      require:
        {
        'diabetes' => '=== "yes"',
        }
     },
    {
      code: 'thyroid-disease',
      text: "Have you been diagnosed with thyroid problems?",
      desc: 'Thyroid disease',
      group: "Endocrine",
      variants: yesNo,
      require: { age: '> 14'}
     },

    {
      code: 'thyroid-function',
      text: "Is your thyroid overactive, underactive or normal?",
      desc: 'Thyroid function',
      group: "Endocrine",
      variants:
        [
        {code: 'hyperthyroid', text: 'Overactive'},
        {code: 'hypothyroid', text: 'Underactive'},
        {code: 'euthyroid', text: 'Normal'},
        {code: 'unknown', text: 'Don\'t know'}
        ],
      require:
        {
        'thyroid-disease' => '=== "yes"'
        }
     },
    {
      code: 'goitre',
      text: "Do you have an enlarged thyroid (goitre)?",
      desc: 'Goitre',
      group: "Endocrine",
      variants: yesNoUnknown,
      require:
        {
        'thyroid-disease' => '=== "yes"'
        }
     },
    {
      code: 'breastfeeding-current',
      text: "Are you breastfeeding?",
      desc: 'Breastfeeding',
      group: "Obstetric",
     variants: yesNo,
      require:
        {
        'gender' => '=== "f"',
        age: ['> 14', '< 50']
        }
     },

    {
      code: 'pregnancy-current',
      text: "Are you, or could you be, pregnant?",
      desc: 'Pregnancy',
      group: "Obstetric",
     variants: yesNo,
      require:
        {
        'gender' => '=== "f"',
        age: ['> 14', '< 50']
        }
     },
     {
      code: 'back-problems-unspecified',
      text: "Have you had any back problems or surgery?",
      desc: 'Back problems',
      group: "Other",
      variants: yesNo,
      require: { age: '> 14'}
     },

     {
      code: 'back-problems-details',
      text: "Please provide some information about these problems with your back or spine.",
      desc: 'Back problems details',
      group: "Other",
      type: 'text',

      require:
        {
        'back-problems-unspecified' => '=== "yes"',
        }
     },
    {
      code: 'renal-disease',
      text: "Do you have any kidney disease or kidney failure?",
      desc: 'Renal disease',
      group: "Other",
      variants: yesNo
     },

    {
      code: 'renal-disease-details',
      text: "Please provide some information about your kidney problems",
      desc: 'Renal disease details',
      type: 'text',
      group: "Other",
      require:
        {
        'renal-disease' => '=== "yes"',
        }
     },
    {
      code: 'bleeding-diathesis',
      text: "Have you ever been diagnosed with a bleeding disorder?",
      desc: 'Bleeding diathesis',
      group: "Other",
      variants: yesNo,
     },

    {
      code: 'bleeding-diathesis-details',
      text: "Please provide some information about these bleeding problems.",
      desc: 'Bleeding diathesis details',
      group: "Other",
      type: 'text',

      require:
        {
        'bleeding-diathesis' => '=== "yes"',
        }
     },

    {
      code: 'internal-disease-other',
      text: "Do you have any other medical problems?",
      desc: 'Other disease',
      group: "Other",
      variants: yesNo,
     },

    {
      code: 'internal-disease-other-details',
      text: "Please provide some information about these problems?",
      desc: 'Other disease details',
      group: "Other",
      type: 'text',

      require:
        {
        'internal-disease-other' => '=== "yes"',
        }
     },

    {
      code: 'investigations-lab-results-one-year',
      text: "Have you had blood tests in the last year?",
      desc: 'Blood test in last year',
      group: "Investigation",
      variants: yesNo,
    },

    {
      code: 'lab-for-results',
      text: "Where did you have these tests done?",
      desc: 'Lab for results',
      group: "Investigation",
      type: 'checklist',
      variants:
        [
        {code: 'Mater', text: 'Mater Pathology'},
        {code: 'QML', text: 'QML'},
        {code: 'S&N', text: 'Sullivan and Nicolaides (S&N)'},
        {code: 'QH', text: 'Queensland Health (Public)'},
        {code: 'Medlab', text: 'Medlab'},
        {code: 'Other', text: 'Other'},
        {code: 'Unknown', text: 'Don\'t know'}
        ],
      require:
        {
        'investigations-lab-results-one-year' => '=== "yes"'
        }
     },

    {
      code: 'consent-to-view-results',
      text: "Is it OK if Dr Belavy looks up the results of these blood tests?",
      desc: 'Lab result consent',
      group: "Investigation",
      variants: yesNo,
      require:
        {
        'investigations-lab-results-one-year' => '=== "yes"'
        }
     },
    {
      code: 'echo-performed',
      text: "Have you ever had an echocardiogram or ultrasound of your heart?",
      desc: 'Echo performed',
      group: "Investigation",
      variants: yesNo,
      require: { age: '> 14'},
    },

    {
      code: 'echo-results',
      text: "Where did you have this test done?",
      desc: 'Lab for echo',
      group: "Investigation",
      require:
        {
        'echo-performed' => '=== "yes"'
        }
     },
    {
      code: 'questions-for-anesthetist',
      text: "Is there anything you would like to ask your anaesthetist? Do you have any comments about this questionnaire?",
      desc: 'Questions for anaesthetist',
      group: "Questions and comments",
      variants: yesNo,
    },

    {
      code: 'questions-for-anesthetist-details',
      text: "What would you like ask?",
      desc: 'Questions for anaesthetist',
      group: "Questions and comments",
      type: 'text',

      require:
        {
        'questions-for-anesthetist' => '=== "yes"',
        }
     },

     {
      code: 'patient-assessment-completed-by-type',
      text: "Who filled out this form?",
      desc: 'Assessment completed by',
      group: "Questions and comments",
      variants:
        [
        {code: 'patient', text: 'Patient'},
        {code: 'other', text: 'Someone else'}
        ],
     },


    {
      code: 'patient-assessment-completed-by-name',
      text: "Who completed the form?",
      group: "Questions and comments",
      desc: 'Assessment completed by',
      require:
        {
        'patient-assessment-completed-by-type' => '=== "other"',
        }
     },
    ]
  end

end
