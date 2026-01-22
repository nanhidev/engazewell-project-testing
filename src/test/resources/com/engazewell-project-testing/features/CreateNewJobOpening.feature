
@feature_create_new_job_opening
Feature: CreateNewJobOpening

  Background: 
    Given the user is logged into the application

  @navigate_job_openings
  Scenario Outline: Create New Job Opening
    When the user clicks on the "Job Openings" module from the main menu
    Then the Job Opening page is displayed with an "Add Job Opening" button visible

  Examples:
    | action                        |
    | Click on "Job Openings"      |

  @verify_job_opening_form
  Scenario Outline: Create New Job Opening
    When the user clicks on the "Add Job Opening" button
    Then the Create New Job Opening form is displayed
    And all required fields are present

  Examples:
    | Job Title       | Job Description | Department  |
    | Software Engineer| Develop software | IT          |

  @valid-job-opening
  Scenario Outline: Create New Job Opening
    Given the user is on the Create Job Opening Page
    When I fill in the Job Title field with a valid title "<job_title>"
    And I fill in the Job Description field with a valid description "<job_description>"
    And I select a valid Department "<department>"
    And I fill in the Location field with "<location>"
    And I select the Employment Type "<employment_type>"
    And I click the Save button
    Then the new job opening is created successfully
    And the user is redirected to the Job Openings listing page
    And the newly created job opening is displayed in the listing

    Examples:
      | job_title         | job_description                                                              | department | location | employment_type |
      | Software Engineer  | Develop and maintain software applications, ensuring high performance and responsiveness. | Engineering | New York | Full-time       |

  @validate_required_fields
  Scenario Outline: Create New Job Opening with Empty Required Fields
    When the user leaves all required fields empty
    And the user clicks the Save button
    Then the system displays error messages for each required field that is empty
    And the user remains on the Create New Job Opening form

    Examples:
      |  |
      |  |

@valid-job-creation
Scenario Outline: Create New Job Opening
  Given the user fills in the Job Title field with "<job_title>"
  And the user fills in the Job Description field with "<job_description>"
  And the user selects "<department>" from the dropdown
  And the user leaves optional fields empty
  When the user clicks the "Save" button
  Then the new job opening should be created successfully
  And the user should be redirected to the Job Openings listing page
  And the newly created job opening should be displayed in the listing

  Examples:
    | job_title        | job_description                                                              | department  |
    | Software Engineer | Develop and maintain software applications, ensuring high performance and responsiveness. | Engineering  |

  @cancel_job_opening
  Scenario Outline: Create New Job Opening
    When the user clicks the Cancel button on the Create New Job Opening form
    Then the user is redirected back to the Job Openings listing page
    And no new job opening is created

    Examples:
      | action  |
      | Cancel  |

  @edit-job-opening
  Scenario Outline: Create New Job Opening
    When the user clicks on the newly created job opening
    And the user clicks the "Edit" button
    And the user modifies the Job Description field to "<job_description>"
    And the user clicks the "Save" button
    Then the job opening is updated successfully
    And the user is redirected to the Job Openings listing page
    And the updated job opening details are displayed in the listing

    Examples:
      | job_description           |
      | New job description text  |

  @view_job_openings
  Scenario Outline: Create New Job Opening
    When the user clicks on the "Job Openings" module
    Then the user should observe the list of job openings
    And the newly created job opening is displayed in the list
    And the job opening details are correct and match the entered data

    Examples:
      | job_title         | job_description                     | department  |
      | Software Engineer  | Develop and maintain software       | IT          |
      | Product Manager    | Oversee product development         | Marketing    |

  @filter_job_openings
  Scenario Outline: Create New Job Opening
    When the user clicks on the filter options
    And the user selects a <Department> from the filter dropdown
    And the user clicks the Apply Filters button
    Then job openings are filtered based on the selected criteria
    And only relevant job openings are displayed in the listing

    Examples:
      | Department    |
      | Engineering    |
      | Marketing      |

  @view-job-opening
  Scenario Outline: Create New Job Opening
    When the user clicks on the newly created job opening
    Then the job opening details are displayed correctly
    And all fields match the data entered during creation

    Examples:
      | job_opening_name       |
      | Newly Created Job      |

  @invalid-job-title
  Scenario Outline: Create New Job Opening with Invalid Job Title
    When I enter "<jobTitle>"
    And I enter "<companyName>"
    And I enter "<location>"
    And I enter "<description>"
    And I enter "<salary>"
    And I click the "Save" button
    Then the system displays an error message indicating the Job Title is invalid
    And the user remains on the Create New Job Opening form

    Examples:
      | jobTitle | companyName      | location          | description          | salary |
      | ab       | validCompanyName | validLocation     | validDescription      | validSalary |

  @invalid-job-description
  Scenario Outline: Create New Job Opening with Invalid Job Description
    Given I enter a Job Description of "<job_description>"
    And I enter a Job Title of "<title>"
    And I enter a Job Location of "<location>"
    And I enter a Salary of "<salary>"
    And I select an Employment Type of "<employment_type>"
    When I click the "Save" button
    Then the system displays an error message indicating the Job Description is too long
    And the user remains on the Create New Job Opening form

    Examples:
      | job_description                     | title             | location  | salary | employment_type |
      | a * 100                             | Software Engineer  | New York | 80000  | Full-time       |

  @invalid-department-selection
  Scenario Outline: Create New Job Opening with Invalid Department
    When I select "<department>"
    And I fill in the Job Title with "<job_title>"
    And I fill in the Description with "<description>"
    And I fill in the Location with "<location>"
    And I fill in the Salary with "<salary>"
    And I click the "Save" button
    Then the system displays an error message indicating the selected Department is invalid
    And the user remains on the Create New Job Opening form

    Examples:
      | department         | job_title         | description           | location         | salary       |
      | Invalid Department  | Valid Job Title   | Valid Description      | Valid Location    | Valid Salary |

  @duplicate-job-title
  Scenario Outline: Create New Job Opening with Duplicate Job Title
    When I enter "<job_title>"
    And I fill in the company name with "<company_name>"
    And I fill in the location with "<location>"
    And I fill in the description with "<description>"
    And I fill in the salary with "<salary>"
    And I click the "Save" button
    Then the system displays an error message indicating the Job Title already exists
    And the user remains on the Create New Job Opening form

    Examples:
      | job_title          | company_name         | location    | description | salary |
      | Software Engineer   | Tech Solutions Inc.  | New York    | a * 100     | 80000  |

  @invalid-data-entry
  Scenario Outline: Create New Job Opening with Invalid Data Types
    Given the user enters "<salary>" in the Salary field
    And the user enters "<job_title>" in the Job Title field
    And the user enters "<location>" in the Location field
    And the user enters "<description>" in the Description field
    And the user enters "<company>" in the Company field
    When the user clicks the Save button
    Then the system displays an error message indicating invalid data type
    And the user remains on the Create New Job Opening form

    Examples:
      | salary | job_title         | location  | description  | company            |
      | abc    | Software Engineer  | New York  | a * 100      | Tech Innovations    |

  @unsaved_changes_warning
  Scenario Outline: Create New Job Opening
    When the user makes changes to the form without saving
    And the user attempts to navigate to another module
    Then the system displays a warning message about unsaved changes
    And the user remains on the Create New Job Opening form until they confirm to leave

    Examples:
      |   |
      |   |

  @invalid-location
  Scenario Outline: Create New Job Opening with Invalid Location
    Given the user enters "<title>" as the job title
    And the user enters "<description>" as the job description
    And the user enters "<company>" as the company name
    And the user enters "<salary>" as the salary
    And the user enters "<location>" as the job location
    When the user clicks the "Save" button
    Then the system displays an error message indicating the location is invalid
    And the user remains on the Create New Job Opening form

    Examples:
      | title                 | description                             | company               | salary | location       |
      | Software Engineer     | Develop and maintain software applications. | Tech Innovations Inc. | 80000  | !@#$%^&*()    |

@create-job-opening-max-chars
Scenario Outline: Create New Job Opening
  Given the user fills in the Job Title field with maximum allowed characters
  And the user fills in the Job Description field with maximum allowed characters
  And the user selects "<department>" from the dropdown
  And the user fills in other required fields with maximum allowed characters
  When the user clicks the "Save" button
  Then a new job opening is created successfully
  And the user is redirected to the Job Openings listing page
  And the newly created job opening is displayed in the listing

  Examples:
    | department   |
    | Engineering  |

  @valid-job-opening
  Scenario Outline: Create New Job Opening
    When I fill in the job opening details with "<job_title>", "<employment_type>", "<experience_required>", "<salary>", "<job_description>", "<location>", "<start_date>", "<end_date>"
    And I click "Save"
    And I quickly click "Add Job Opening"
    When I fill in the job opening details with "<job_title_2>", "<employment_type_2>", "<experience_required_2>", "<salary_2>", "<job_description_2>", "<location_2>", "<start_date_2>", "<end_date_2>"
    And I click "Save" for the second job opening
    Then both job openings should be created successfully
    And I should be redirected to the Job Openings listing page after each save
    And both job openings should be displayed in the listing

    Examples:
      | job_title        | employment_type | experience_required | salary | job_description                        | location   | start_date  | end_date    | job_title_2       | employment_type_2 | experience_required_2 | salary_2 | job_description_2                      | location_2 | start_date_2 | end_date_2  |
      | Software Engineer | Full-time       | 5 years            | 100000 | Develop and maintain software applications. | New York   | 2023-10-01  | 2023-10-31  | Software Engineer   | Full-time         | 5 years             | 100000   | Develop and maintain software applications. | New York   | 2023-10-01  | 2023-10-31  |

  @valid-job-opening
  Scenario Outline: Create New Job Opening
    Given the user fills in the Job Title field with "<job_title>"
    And the user fills in the Job Description field with "<job_description>"
    And the user selects "<department>" from the dropdown
    And the user fills in other required fields with valid data
    When the user clicks the "Save" button
    Then a new job opening is created successfully
    And the user is redirected to the Job Openings listing page
    And the newly created job opening is displayed in the listing

    Examples:
      | job_title                        | job_description                                                                                                               | department   |
      | Software Engineer @ Tech Co.    | We are looking for a Software Engineer who can develop & maintain applications, ensuring high performance & responsiveness. | Engineering   |
