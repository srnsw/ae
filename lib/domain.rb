#
# A module for customising 1) the default namespace used by XML functions
# within the application and  2) the template for a new XML authority.
#
module Namespace
  # Default namespace.
  RDA = {'rda' => 'http://www.records.nsw.gov.au/schemas/RDA'}
  # Template for a new authority (used when 'File - New' is selected).
  NEW = '<Authority xmlns="http://www.records.nsw.gov.au/schemas/RDA"></Authority>'
end

#
# The Domain module allows customisation of jurisdiction-specific terminology.
#
module Domain
  # Set VALIDATE to false if you change defaults in this module that are required
  # by SRNSW's schema (i.e. ID controls, RDA controls, term types, disposal actions).
  VALIDATE = true
  # ... or leave VALIDATE true and give a new location to your own custom XML schema
  SCHEMALOCATION = 'data/SRNSW_RDA_permissive.xsd'
  NAME = 'State Records'
  SHORTNAME = 'SRNSW'
  # The following arrays are the lists that appear in drop downs within the program.
  # Most can be changed without problems (although changing id/rda controls,
  # term types, or disposal actions may cause validation errors).
  IDCONTROLS = ['AgencyRef', 'SRFileNo', 'AR', 'FA', 'GA', 'DA', 'GDA', 'DR']
  # RDACONTROLS are a subset of IDCONTROLS that contain controls suitable
  # for see references and supersede elements.
  RDACONTROLS = ['FA', 'GA', 'DA', 'GDA', 'DR']
  TERMTYPES = ['function', 'activity', 'subfunction', 'subactivity', 'series', 'subject']
  LINKEDTOTYPES = ['linking table', 'index', 'mandate', 'business unit',
  'agency classification scheme', 'SRNSW appraisal objective', 'SRNSW function',
  'SRNSW activity']
  DISPOSALCONDITIONS = ['If longer', 'If shorter', 'For records relating to...', 
  'Automated', 'Authorised', 'Following transfer']
  DISPOSALTRIGGERS = ['action completed', 'superseded', 'reference use ceases',
  'administrative or reference use ceases', 'expiry or termination of agreement',
  'expiry or termination of contract', 'expiry or termination of lease', 'expiry or termination of licence']
  DISPOSALACTIONS = ['Required as State archives', 'Destroy', 'Retain in agency', 'Transfer']
  CONTEXTTYPES = ['supporting documentation', 'table of commentary']
  # The following hashes control the right-click menus that appear in the tree menu.
  # CONTEXTSETS is an array of hashes that allow you to pre-populate with standard context elements.
  # If you don't want any, leave an empty array i.e. CONTEXTSETS = [].
  CONTEXTSETS = [{
    :menu_text => 'Add supporting documentation',
    :type => 'supporting documentation',
    :titles => ['About the organisation', 'About relationships with other organisations and stakeholders', 'About committees', 'About the records held by the organisation', 'About any external stakeholder consultation undertaken']
    },
    {
    :menu_text => 'Add table of commentary',
    :type => 'table of commentary',
    :titles => ['Summary', 'Comment and Response 1', 'Comment and Response 2', 'Comment and Response 3']
    }
    ]
  # The term sets allow groups of terms and classes to be added at once.
  # TERMSET1 shows at the top level, TERMSET2 at the second level.
  # You must leave them in, but can set :show to false to hide them.
  # Each set will add nested and typed terms for as many types as you stick
  # in the :terms array. A disposal class is automatically nested at the bottom of
  # that term hierarchy.
  # The :pref value controls the label text that appears in the View - Preferences menu.
  TERMSET1 = {
    :pref => '_Function-activity-class only', 
    :show => true,
    :menu_text => 'Add function-activity-class',
    :terms => ['function', 'activity']
    }
  TERMSET2 = {
    :show => true,
    :menu_text => 'Add activity-class',
    :terms => ['activity']
    }
  # GENERALAUTHORITIES is an array of hashes. You can add as many
  # general authorities as you need (SRNSW uses two). To hide, simply
  # delete all hashes within the array.
  GENERALAUTHORITIES = [
  {
  :short_title => 'GDA12',
  :id_control => 'GDA',
  :id_number => '12',
  :long_title => 'Personnel records',
  :terms => {
    'OCCUPATIONAL HEALTH AND SAFETY' => ['', 'Health promotion'],
    'PERSONNEL' => ['', 'Allowances', 'Appeals (decisions)', 'Arrangements', 'Audit', 'Authorisation', 'Committees', 'Compliance', 'Contracting-out', 'Counselling', 'Discipline', 'Employee files', 'Employment conditions', 'Evaluation', 'Grievances', 'Infringements', 'Insurance', 'Leave', 'Marketing', 'Performance management', 'Planning', 'Policy', 'Procedures', 'Recruitment', 'Rehabilitation', 'Representatives', 'Salaries', 'Security', 'Separations', 'Social clubs', 'Suggestions']
    }
  },
  {
  :short_title => 'GA28', 
  :id_control => 'GA', 
  :id_number => '28', 
  :long_title => 'Administrative records',
  :terms => {
    'COMMITTEES' => [''], 
    'COMMUNITY RELATIONS' => ['','Acquisition', 'Addresses', 'Agreements', 'Celebrations, ceremonies, functions', 'Conferences', 'Customer service', 'Donations', 'Enquiries', 'Evaluation', 'Exhibitions', 'Greetings', 'Joint ventures', 'Liaison', 'Marketing', 'Media relations', 'Planning', 'Policy', 'Procedures', 'Public reaction', 'Reporting', 'Reviewing', 'Submissions', 'Visits'],
    'COMPENSATION' => ['','Advice', 'Claims', 'Compliance', 'Insurance', 'Policy', 'Procedures', 'Reviewing'],
    'CONTRACTING-OUT' => [''],
    'EQUIPMENT & STORES' => ['','Acquisition', 'Agreements', 'Allocation', 'Arrangements', 'Audit', 'Claims', 'Compliance', 'Disposal', 'Evaluation', 'Installation', 'Insurance', 'Leasing', 'Leasing-out', 'Maintenance', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Security', 'Stocktake'],
    'ESTABLISHMENT' => ['','Evaluation', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Restructuring', 'Variations'],
    'FINANCIAL MANAGEMENT' => ['','Accounting', 'Advice', 'Agreements', 'Allocation', 'Asset register', 'Audit', 'Authorisation', 'Budgeting', 'Compliance', 'Corruption', 'Evaluation', 'Financial statements', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Salaries', 'Treasury management'],
    'FLEET MANAGEMENT' => ['','Accidents', 'Acquisition', 'Arrangements', 'Authorisation', 'Claims', 'Compliance', 'Disposal', 'Infringements', 'Insurance', 'Leasing', 'Leasing-out', 'Maintenance', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing'],
    'GOVERNING BODIES' => ['','Advice', 'Agreements', 'Appeals', 'Arrangements', 'Audit', 'Authorisation', 'Authorities', 'Compliance', 'Corruption', 'Meetings', 'Membership', 'Performance management', 'Policy', 'Procedures', 'Training and development'],
    'GOVERNMENT RELATIONS' => ['','Addresses','Advice', 'Agreements', 'Authorisation', 'Compliance', 'Inquiries', 'Legislation', 'Meetings', 'Policy', 'Procedures', 'Reporting', 'Representations', 'Submissions', 'Visits'],
    'INDUSTRIAL RELATIONS' => ['','Agreements', 'Appeals', 'Claims', 'Disputes', 'Grievances', 'Insurance', 'Meetings', 'Planning', 'Policy', 'Procedures', 'Reporting'],
    'INFORMATION MANAGEMENT'=> ['','Acquisition', 'Agreements', 'Appeals', 'Audit', 'Authorisation', 'Cases', 'Compliance', 'Conservation', 'Control', 'Customer service', 'Disposal', 'Distribution', 'Donations', 'Enquiries', 'Evaluation', 'Implementation', 'Intellectual property', 'Inventory', 'Marketing', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Security'],
    'LEGAL SERVICES' => ['','Advice', 'Agreements', 'Compliance', 'Litigation', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Research', 'Reviewing'],
    'OCCUPATIONAL HEALTH & SAFETY' => ['','Accidents', 'Appeals', 'Audit', 'Compliance', 'Health promotion', 'Inspections', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Representatives', 'Reviewing', 'Risk management', 'Standards'],
    'PERSONNEL' => ['','Compliance', 'Insurance', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Salaries'],
    'PROPERTY MANAGEMENT' => ['','Acquisition', 'Arrangements', 'Audit', 'Claims', 'Compliance', 'Conservation', 'Construction', 'Disposal', 'Evaluation', 'Flora and fauna management', 'Inspections', 'Installation', 'Insurance', 'Leasing', 'Leasing-out', 'Maintenance', 'Moving', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Risk management', 'Security'],
    'PUBLICATION' => ['','Agreements', 'Authorisation', 'Compliance', 'Corporate style', 'Distribution', 'Drafting', 'Enquiries', 'Evaluation', 'Intellectual property', 'Joint ventures', 'Marketing', 'Planning', 'Policy', 'Procedures', 'Production', 'Reporting', 'Reviewing', 'Stocktake'],
    'STAFF DEVELOPMENT'=>['','Acquisition', 'Addresses', 'Audit', 'Conferences', 'Evaluation', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Training'],
    'STRATEGIC MANAGEMENT'=> ['','Agreements', 'Audit', 'Authorisation', 'Compliance', 'Corruption', 'Customer service', 'Evaluation', 'Grant funding', 'Implementation', 'Intellectual property', 'Joint ventures', 'Legislation', 'Meetings', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Reviewing', 'Risk management', 'Standards'],
    'TECHNOLOGY & TELECOMMUNICATIONS' => ['','Acquisition', 'Agreements', 'Allocation', 'Application development and management', 'Arrangements', 'Audit', 'Compliance', 'Customer service', 'Data administration', 'Disposal', 'Evaluation', 'Implementation', 'Installation', 'Intellectual property', 'Leasing-out', 'Maintenance', 'Planning', 'Policy', 'Procedures', 'Reporting', 'Restructuring', 'Reviewing', 'Security'],
    'TENDERING' => ['']
    }
  }
  ]
end
