Feature: CRUD authors

  Scenario: List all authors page
    When loading the home page "http://localhost:4200/author/list"
    Then the title is "List of authors"
    Then the main button is "Create"

  Scenario: Create an author page
    When loading the home page "http://localhost:4200/author/list"
    And click on button "Create"
    Then the title is "Create author"
    And author information:
      | authorName  | email                 | birthDate  |
      | C. S. Lewis | c.s.lewis@hotmail.com | 11/22/1963 |
    And enter author information
    And click on button "Submit"
    Then the title is "List of authors"
    Then author should be on the list

  Scenario: Read author details page
    When loading the home page "http://localhost:4200/author/list"
    And author information:
          | authorName  | email                 | birthDate  |
          | C. S. Lewis | c.s.lewis@hotmail.com | 11/22/1963 |
    And click on author
    Then the title is "Detail of an author"
    And click on button "Back"
    Then the title is "List of authors"
    And click on author
    Then the title is "Detail of an author"
    Then author should be on form

  Scenario: Update author details page
    When loading the home page "http://localhost:4200/author/list"
    And author information:
          | authorName  | email                 | birthDate  |
          | C. S. Lewis | c.s.lewis@hotmail.com | 11/22/1963 |
    And click on author
    Then the title is "Detail of an author"
    And author information:
      | authorName  | email                 | birthDate  |
      | William Shakespeare | william.shakespeare@nasa.gov | 04/23/1564 |
    Then click on button "Edit"
    Then the title is "Edit author"
    And enter author information
    And click on button "Submit"
    Then author should be on the list

  Scenario: Delete author page
    When loading the home page "http://localhost:4200/author/list"
    And author information:
      | authorName  | email                 | birthDate  |
      | William Shakespeare | william.shakespeare@nasa.gov | 04/23/1564 |
    And click on author
    And click on button "Delete"
    Then the title is "List of authors"
    Then author should not be on the list
