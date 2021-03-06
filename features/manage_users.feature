Feature: Manage Users
  CMS Admins should be able to add/edit/disable users via the Admin UI.

  Background:
    Given I am logged in as a Content Editor

  Scenario: List Users
    When I view the list of users
    Then I should see myself on the list

  Scenario: Search for users by email
    Given the following user exists:
      | email              |
      | sample@example.com |
    And there exists some other users
    When I search for a user with "sample"
    Then I should see only that user

  Scenario: Search for users by login
    Given the following user exists:
      | login       |
      | sample-user |
    And there exists some other users
    When I search for a user with "sample"
    Then I should see only that user

  Scenario: Search for users by first name
    Given the following user exists:
      | first_name |
      | Stan       |
    And there exists some other users
    When I search for a user with "Stan"
    Then I should see only that user

  Scenario: Search for users by first name
    Given the following user exists:
      | last_name |
      | Marsh     |
    And there exists some other users
    When I search for a user with "Marsh"
    Then I should see only that user

  Scenario: Search for users by group
    Given the following user exists:
      | email              | group        |
      | sample@example.com | Contributors |
    And there exists some other users
    When I search for users with group "Contributors"
    Then I should see only that user

  Scenario: Add User
    Given I request /cms/users
    And I add a new user
    Then I should see a page titled "New User"
    When fill valid fields for a new user named "testuser"
    Then I should see a page titled "User Browser"
    And I should see the following content:
      | testuser |

  Scenario: Update username
    Given the following content editor exists:
      | username | password | first_name | last_name |
      | testuser | abc123   | Mr         | Blank     |
    When I request /cms/users
    And I click on "Mr Blank"
    And I fill in "First Name" with "Mister"
    And I press "Save"
    Then I should see the following content:
      | Mister Blank |

  Scenario: Change Password
    Given the following content editor exists:
      | username | password | first_name | last_name |
      | testuser | abc123   | Mr         | Blank     |
    When I request /cms/users
    And I click on "Mr Blank"
    And I click on "Change Password"
    And I fill in "Password" with "different"
    And I fill in "Confirm Password" with "different"
    And I press "Save"
    Then I should see a page titled "User Browser"
    When I login as:
      | login    | password  |
      | testuser | different |
    Then I should see a page titled "Home"

  Scenario: Multiple Pages of Users
    Given there are 20 users
    When I am at /cms/users
    Then I should see "Displaying 1 - 10 of 20"
    When I click on "next_page_link"
    Then I should see "Displaying 11 - 20 of 20"

  Scenario: Disabled Users aren't show by default
    Given the following disabled user exists:
      | email            |
      | none@example.com |
    When I view the list of users
    Then I should not see that user

  Scenario: Show expired users
    Given the following disabled user exists:
      | email            |
      | none@example.com |
    When I search for expired users
    Then I should see that user

  Scenario: Update a group
    Given the following user exists:
      | login    |
      | testuser |
    When I add that user to a new group
    Then that user should have 1 group




