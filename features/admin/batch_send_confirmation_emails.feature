Feature: Admins can batch send confirmation emails to teams

  Scenario: Admin sends an email to some recipients
    Given the following race teams exist:
      | Name                | Class       | Leader Name  | Leader Email             | Rider 1 Email        | Rider 2 Email       |
      | Bot and Rose Design | A Team      | Micah Geisel | info@botandrose.com      | micah@botandrose.com | gubs@botandrose.com |
      | Bog and Rat Defeat  | B Team      | Hacim Leseig | info@bogandrat.com       | micah@bogandrat.com  | gubs@bogandrat.com  |
      | Micah               | Solo (male) | Micah Diesel | originofstorms@gmail.com | | |
    And I am logged in as an Admin

    When I follow "Races"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME           | RIDERS | LEADER NAME  |
      | No   | No      | 1    | A     | Bot and Rose Design | 3      | Micah Geisel |
      | No   | No      | 2    | B     | Bog and Rat Defeat  | 3      | Hacim Leseig |
      | No   | No      | 3    | S     | Micah               | 1      | Micah Diesel |
    
    When I check "Bot and Rose Design"
    And I check "Micah"
    And I press "Send Confirmation Email"
    # Then I should see "Confirmation emails sending!"
    Then I should see the following teams:
      | PAID | EMAILED | POS# | CLASS | TEAM NAME           | RIDERS | LEADER NAME  |
      | No   | Yes     | 1    | A     | Bot and Rose Design | 3      | Micah Geisel |
      | No   | No      | 2    | B     | Bog and Rat Defeat  | 3      | Hacim Leseig |
      | No   | Yes     | 3    | S     | Micah               | 1      | Micah Diesel |

    And "info@botandrose.com" should receive an email
    And "micah@botandrose.com" should receive an email
    And "gubs@botandrose.com" should receive an email

    And "info@bogandrat.com" should receive no emails
    And "micah@bogandrat.com" should receive no emails
    And "gubs@bogandrat.com" should receive no emails

    And "originofstorms@gmail.com" should receive an email

    When "info@botandrose.com" opens the email with subject "RW24 2013 Confirmation: Bot and Rose Design (#1) - A Team - Shirts: M, M, M"
    Then they should see the following in the email body:
      """
      Team name: Bot and Rose Design
      Position: 1
      Class: A Team
      Shirt sizes: M, M, M

      ---

      Thank you for registering for RW24 2013!  Let us know if there are any changes you need to your information above, especially shirt sizes.   We need confirmation QUICKLY on what shirt sizes you need.   We will be placing our orders for shirts shortly.   Let us know quickly or we cannot guarantee size.   But we promise to have a shirt for you.

      Find the rider check-in July 26th, and we will give you the goods (t-shirt,spoke card, meal tickets) so you can get ready for the race.  We STRONGLY encourage you to arrive early, meet your fellow riders, check out our neighborhood, and make a preliminary lap.  Say hello, introduce yourself to strangers.  This race is about community, and our community is strengthened with your help.  Be a friendly human.


      FRIDAY, JULY 26th:

      12p - 6p: Rider Check In.  Please report to the corner of Pierce and Clark, just off the 2600 block of N Pierce St.  Sign your waiver (required), receive your manifest (this is what the checkpoints will punch to count your laps) and check out the competition.  If you are the first person to arrive for your team, you will be given all gear for your entire team.  EVERY rider, however,  will still be required to check in and sign a waiver.


      6p-8p: REGISTRATION IS CLOSED.  If you don't arrive before 6p to start the race, you will NOT be able to register until 8p.

      We suggest/urge/implore/encourage you to arrive to register you and/or your team between noon and 6p.  You will not be happy when we close the registration tent on the corner of Pierce and Clarke and you can not start the race until we re-open (at starting line) at 8p.


      3p-6p: Dinner will be served to all registered riders at the Riverwest Co-Op (733 E Center, 53212).


      6:30p: Rider Meeting and Opening Ceremony.  ALL RIDERS MUST ATTEND.  This is where we will announce any last minute changes, traffic warnings, and road hazards.  This is where you will be reminded to obey traffic laws and wear a helmet.  We all know there are pockets of construction and/or potholes in the neighborhood at any moment, and we will be keeping our eye to let you know the day of the race how everything looks.  We will go over the race rules (this is important), bonus checkpoints (so is this), and any other last minute logistics.


      7p: Race Begins!  You will be lined up, in order, so check your Position (in the subject line of this email).   We will be releasing pairs of riders to AS TRAFFIC ALLOWS.   Center Street is a major intersection and we need to stagger everyone every 30 seconds or so.   This is a neighborhood, urban ride...the streets are open to all forms of traffic, not just bicycles.   We want you to ride safe.


      SATURDAY, JULY 27:

      7a - 9a: Breakfast will again be a strongly-encouraged Bonus Checkpoint.  Free Laps for all who attend.  Exact location announced with all other bonus checkpoints.


      7p: Race Ends and the final tallying begins.  Join us for a finish line photo and awards ceremony.  Laps ridden + bonus checkpoint laps = Your final score.  You won't remember your final lap count as well as you will remember the neighborhood cheering you on.  Or the kindness of a spare tube shared with a stranger.  Or a clarinet solo by a neighbor on his porch at 2AM.  Or seeing yourself, pushing harder and riding further than you ever thought you could.  RW24 ends up being a lot of different things to a lot of people.  Join us in making it another great community celebration.


      See you at the starting line!
      """
