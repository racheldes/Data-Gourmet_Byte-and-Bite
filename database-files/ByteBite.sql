DROP DATABASE IF EXISTS ByteBite;
CREATE DATABASE IF NOT EXISTS ByteBite;

USE ByteBite;

-- create users table
DROP TABLE IF EXISTS Users;
CREATE TABLE IF NOT EXISTS Users (
    userID   int AUTO_INCREMENT PRIMARY KEY,
    username varchar(50) NOT NULL UNIQUE,
    age      int,
    gender   varchar(50),
    role     varchar(50) NOT NULL,
    location varchar(75),
    email    varchar(75) NOT NULL,
    password varchar(50) NOT NULL,
    INDEX idx_username (username)
);

-- create Recipes table
DROP TABLE IF EXISTS Recipes;
CREATE TABLE IF NOT EXISTS Recipes (
    recipeID   int AUTO_INCREMENT PRIMARY KEY,
    username varchar(50) NOT NULL,
    rating int,
    date DATETIME DEFAULT CURRENT_TIMESTAMP,
    ingredients mediumtext NOT NULL,
    directions mediumtext,
    allergens varchar(50),
    INDEX idx_username (username),
    recipeUserID int,
    CONSTRAINT fk_recipe_user
        FOREIGN KEY (recipeUserID) REFERENCES Users (userID)
            ON UPDATE cascade ON DELETE restrict

);

-- create commentReviews table
DROP TABLE IF EXISTS Reviews;
CREATE TABLE IF NOT EXISTS Reviews (
    reviewID int AUTO_INCREMENT,
    reviewUserID int,
    comment mediumTEXT,
    rating int,
    PRIMARY KEY (reviewID, reviewUserID),
    CONSTRAINT fk_2
        FOREIGN KEY (reviewUserID) REFERENCES Users (userID)
            ON UPDATE cascade ON DELETE restrict
);

-- create tags table
DROP TABLE IF EXISTS Tags;
CREATE TABLE IF NOT EXISTS Tags (
    tagID int AUTO_INCREMENT PRIMARY KEY,
    tagName varchar(50)
);

-- create tag_posts table
DROP TABLE IF EXISTS tagsPosts;
CREATE TABLE IF NOT EXISTS tagsPosts (
     tagID int,
     recipeID int,
     PRIMARY KEY (tagID, recipeID),
    CONSTRAINT fk_3
        FOREIGN KEY (tagID) REFERENCES Tags (tagID)
            ON UPDATE cascade ON DELETE restrict,
    CONSTRAINT fk_4
        FOREIGN KEY (recipeID) REFERENCES Recipes (recipeID)
            ON UPDATE cascade ON DELETE restrict
);

-- create meal plan table
DROP TABLE IF EXISTS MealPlan;
CREATE TABLE IF NOT EXISTS MealPlan (
   mealPlanId INT AUTO_INCREMENT PRIMARY KEY,
   addDate DATETIME DEFAULT CURRENT_TIMESTAMP,
   allergens VARCHAR(75),
   userID int NOT NULL,
   FOREIGN KEY (userID) REFERENCES Users (userId)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

-- create meal plan goals
DROP TABLE IF EXISTS MealPlan_goals;
CREATE TABLE IF NOT EXISTS MealPlan_goals (
   mealPlanId INT NOT NULL,
   goals VARCHAR(75) NOT NULL,

   PRIMARY KEY (mealPlanId, goals),
   FOREIGN KEY (mealPlanId) REFERENCES MealPlan (mealPlanId)
       ON DELETE RESTRICT
       ON UPDATE CASCADE
);

-- create meal plan info
DROP TABLE IF EXISTS MealPlanInfo;
CREATE TABLE IF NOT EXISTS MealPlanInfo (
   mealPlanInfoID INT AUTO_INCREMENT NOT NULL,
   recipeID INT NOT NULL,
   allergens VARCHAR(75),
   PRIMARY KEY (mealPlanInfoID),
   FOREIGN KEY (mealPlanInfoID) REFERENCES MealPlan(mealPlanId)
);

-- create meal plan info goals table
DROP TABLE IF EXISTS MealPlanInfo_goals;
CREATE TABLE IF NOT EXISTS MealPlanInfo_goals (
       mealPlanInfoId INT NOT NULL,
       goals VARCHAR(75) NOT NULL,
       PRIMARY KEY (mealPlanInfoId, goals),
       FOREIGN KEY (mealPlanInfoId) REFERENCES MealPlanInfo(mealPlanInfoID)
                   ON DELETE RESTRICT
                   ON UPDATE CASCADE
);

-- create recipe meal plan info
DROP TABLE IF EXISTS Recipe_MealPlanInfo;
CREATE TABLE IF NOT EXISTS Recipe_MealPlanInfo (
   mealPlanInfoId INT NOT NULL,
   recipeID INT NOT NULL,
   PRIMARY KEY (mealPlanInfoId, recipeID),
   FOREIGN KEY (mealPlanInfoId) REFERENCES MealPlanInfo(mealPlanInfoID)
               ON DELETE RESTRICT
               ON UPDATE CASCADE,
   FOREIGN KEY (recipeID) REFERENCES Recipes(recipeID)
       ON DELETE RESTRICT
       ON UPDATE CASCADE
);

-- create UserInfo table
DROP TABLE IF EXISTS UserInfo;
CREATE TABLE IF NOT EXISTS UserInfo (
   userinfoID int NOT NULL,
   userID int NOT NULL,
   mealPlanCount int NOT NULL,
   lastLoggedOn datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   commentCount int,
   CONSTRAINT pk_UI PRIMARY KEY(userinfoID, userID),
   CONSTRAINT fk_uUI FOREIGN KEY (userID) REFERENCES Users (userID)
       ON UPDATE RESTRICT
       ON DELETE RESTRICT
);


-- UserDemographics table
DROP TABLE IF EXISTS UserDemographics;
CREATE TABLE IF NOT EXISTS UserDemographics (
   demographicID int NOT NULL,
   demUserID int NOT NULL,
   avgAge float,
   avgGender varchar(50),
   allergenFrequency decimal(5,3),
   goalFrequency decimal(5,3),
   CONSTRAINT pk_UD PRIMARY KEY(demographicID, demUserID),
   CONSTRAINT fk_uUD FOREIGN KEY (demUserID) REFERENCES Users(userID)
       ON UPDATE RESTRICT
       ON DELETE RESTRICT
);


-- InvestorReport table
DROP TABLE IF EXISTS InvestorReport;
CREATE TABLE IF NOT EXISTS InvestorReport (
   reportID int NOT NULL PRIMARY KEY,
   investUserID int NOT NULL,
   dateGenerated datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
   growthRate decimal(5,3) NOT NULL,
   CONSTRAINT fk_uIR FOREIGN KEY (investUserID) REFERENCES Users(userID)
       ON UPDATE RESTRICT
       ON DELETE RESTRICT
);

-- create content moderation table
DROP TABLE IF EXISTS ContentModeration;
CREATE TABLE IF NOT EXISTS ContentModeration (
   ModerationID INT AUTO_INCREMENT PRIMARY KEY,
   dateModerated DATETIME DEFAULT CURRENT_TIMESTAMP,
   action varchar(100),
   modRecipeID INT,
   modUserID INT,
 CONSTRAINT
     fk_content_mod_post FOREIGN KEY (modRecipeID) REFERENCES Recipes (recipeID)
       ON UPDATE CASCADE ON DELETE RESTRICT,
   CONSTRAINT
       fk_content_mod_user FOREIGN KEY (modUserID) REFERENCES Users (Userid)
       ON UPDATE CASCADE ON DELETE RESTRICT
);

-- create app update table
DROP TABLE IF EXISTS AppUpdate;
CREATE TABLE IF NOT EXISTS AppUpdate (
   updateID INT AUTO_INCREMENT PRIMARY KEY,
   dateImplemented DATETIME DEFAULT CURRENT_TIMESTAMP,
   version varchar(20),
   appUserID INT,
  CONSTRAINT fk_app_update_user FOREIGN KEY (appUserID) REFERENCES Users (Userid)
);

# create report manangement table
DROP TABLE IF EXISTS ReportManagement;
CREATE TABLE IF NOT EXISTS ReportManagement (
   reportID INT AUTO_INCREMENT PRIMARY KEY,
   dateReported DATETIME DEFAULT CURRENT_TIMESTAMP,
   action VARCHAR(100),
   status VARCHAR(50),
   reportUserID INT,
  CONSTRAINT fk_report_mgmt_user FOREIGN KEY (reportUserID) REFERENCES Users (Userid)
       ON UPDATE CASCADE ON DELETE RESTRICT
);



-- insert sample user
INSERT INTO Users (username, age, gender, role, location, email, password)
    VALUES('susanne', 65, 'female', 'Nutritionist', 'seaport',
           's.miller@gmail.com', 'livelovelaugh');

INSERT INTO Users (username, age, gender, role, location, email, password)
VALUES
('fitguru23', 28, 'Female', 'member', 'Austin, TX', 'fitguru23@example.com', 'pass1234'),
('plantlover88', 25, 'Non-binary', 'member', 'Brooklyn, NY', 'plantlover88@example.com', 'greenpass789');

-- insert sample posts
INSERT INTO Recipes (username, rating, ingredients, directions)
    VALUES('susanne', 8, '1 cup broccoli, 1 carrot sliced,
1 bell pepper chopped, 1 zucchini sliced, 2 tbsp soy sauce, 1 tbsp olive oil, 1 clove garlic
minced, 1 tsp sesame oil', '1. Heat olive oil in a pan, sauté garlic for 1 min. 2. Add veggies,
stir-fry for 5-7 mins. 3. Stir in soy sauce and sesame oil, cook 2 mins. 4, Serve with rice or noodles. Enjoy!');

INSERT INTO Recipes (username, rating, ingredients, directions)
    VALUES('susanne', 10, '1 cup cooked quinoa, 1/2 cup shredded carrots, 1/2 cup
cucumber sliced, 1/2 avocado sliced, 2 tbsp peanut butter, 1 tbsp soy sauce, 1 tsp lime juice',
           '1. Arrange quinoa, carrots, cucumber, and avocado in a bowl. 2. In a small bowl, mix peanut
butter, soy sauce, lime juice, and honey (if using). 3. Drizzle peanut sauce over the veggies and quinoa. 4. Toss gently
and serve. Enjoy!');

-- insert sample tags
INSERT INTO Tags (tagName)
    VALUES ('#HighProtein');

INSERT INTO Tags (tagName)
    VALUES ('#LowCalorie');

INSERT INTO Tags (tagName)
    VALUES ('#HighCalorie');

-- insert sample comment reviews
INSERT INTO Reviews (reviewUserID, comment)
    VALUES (1, 'This meal plan is balanced, with an excellent mix of macronutrients and
micronutrients. It includes a variety of vegetables, lean proteins, and whole grains, making it a healthy choice for
most individuals');

INSERT INTO Reviews (reviewUserID, comment)
    VALUES (1, 'Incorporating more fiber-rich foods like fruits, vegetables, and legumes can help
improve digestion and overall gut health.');

-- insert sample tags_posts
INSERT INTO tagsPosts
    VALUES (2,1);

INSERT INTO tagsPosts
    VALUES (1,2);

-- userinfo values
INSERT INTO UserInfo (userinfoID, userID, mealPlanCount, lastLoggedOn, commentCount)
VALUES
(1, 1, 5, '2025-03-31 14:25:00', 12),
(2, 2, 12, '2025-03-30 10:45:00', 34),
(3, 3, 8, '2025-03-29 18:10:00', 21);


-- user demographics values
INSERT INTO UserDemographics (demographicID, demUserID, avgAge, avgGender, allergenFrequency, goalFrequency)
VALUES
(1, 1, 29.5, 'Female', 0.120, 0.850),
(2, 2, 33.2, 'Male', 0.045, 0.790),
(3, 3, 26.1, 'Non-binary', 0.210, 0.910);


-- investor report values
INSERT INTO InvestorReport (reportID, investUserID, dateGenerated, growthRate)
VALUES
(1, 2, '2025-03-31 09:00:00', 0.135),
(2, 3, '2025-03-30 11:45:00', 0.078),
(3, 1, '2025-03-29 16:30:00', 0.154);

-- contantmod values
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES
('2025-03-31 12:00:00', 'Post removed for inappropriate content', 1, 2),
('2025-03-29 15:30:00', 'User warned for offensive language', 2, 3);


-- appupdate
INSERT INTO AppUpdate (dateImplemented, version, appUserID) VALUES
('2025-03-25 09:00:00', '1.0.1', 1),
('2025-03-20 14:45:00', '1.0.0', 3);


-- reportmanagment
INSERT INTO ReportManagement (dateReported, action, status, reportUserID) VALUES
('2025-03-31 11:30:00', 'Reviewed and dismissed', 'Closed', 2),
('2025-03-30 16:00:00', 'User issued a warning', 'Resolved', 1);

-- meal plan
INSERT INTO MealPlan (addDate, allergens, userID)
VALUES ('2025-03-31 11:30:00', NULL, 1),
       ('2025-03-30 16:00:00', 'Peanuts', 2);


-- mealplan_goals
INSERT INTO MealPlan_goals (mealPlanId, goals)
VALUES (1, 'high protein'),
       (2, 'low carb');


-- mealplaninfo
INSERT INTO MealPlanInfo (mealPlanInfoID, recipeID, allergens)
VALUES (1, 1, 'cherries'),
       (2, 2, 'peanuts');

-- recipe_mealplaninfo
INSERT INTO Recipe_MealPlanInfo
VALUES (1, 2),
       (2,1);

-- mealplan_info goals
INSERT INTO MealPlanInfo_goals
VALUES (1, 'low calorie'),
       (2, 'variety');
