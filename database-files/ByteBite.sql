
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
            ON UPDATE cascade ON DELETE cascade

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
            ON UPDATE cascade ON DELETE cascade,
    CONSTRAINT fk_4
        FOREIGN KEY (recipeID) REFERENCES Recipes (recipeID)
            ON UPDATE cascade ON DELETE cascade
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
               ON DELETE CASCADE
               ON UPDATE CASCADE,
   FOREIGN KEY (recipeID) REFERENCES Recipes(recipeID)
       ON DELETE CASCADE
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
       ON UPDATE CASCADE ON DELETE CASCADE,
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

-- create report manangement table
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



SELECT *
FROM Recipes;


-- insert 30 sample meal plans
insert into MealPlan (addDate, allergens, userID) values ('2025-02-17 18:21:31', 'Tree nuts', 22);
insert into MealPlan (addDate, allergens, userID) values ('2024-10-31 18:21:31', null, 14);
insert into MealPlan (addDate, allergens, userID) values ('2025-02-18 14:33:13', 'Peanuts', 24);
insert into MealPlan (addDate, allergens, userID) values ('2024-12-06 08:39:02', 'Gluten', 2);
insert into MealPlan (addDate, allergens, userID) values ('2024-12-15 20:58:50', null, 24);
insert into MealPlan (addDate, allergens, userID) values ('2024-12-11 21:02:26', null, 19);
insert into MealPlan (addDate, allergens, userID) values ('2024-12-08 16:27:37', null, 8);
insert into MealPlan (addDate, allergens, userID) values ('2024-04-12 04:17:26', 'Wheat', 22);
insert into MealPlan (addDate, allergens, userID) values ('2024-09-12 14:20:29', null, 21);
insert into MealPlan (addDate, allergens, userID) values ('2024-05-24 13:11:14', 'Wheat', 9);
insert into MealPlan (addDate, allergens, userID) values ('2024-05-24 23:17:23', null, 28);
insert into MealPlan (addDate, allergens, userID) values ('2025-02-08 21:07:55', 'Gluten', 21);
insert into MealPlan (addDate, allergens, userID) values ('2025-03-13 14:26:41', 'Tree nuts', 7);
insert into MealPlan (addDate, allergens, userID) values ('2024-06-14 20:22:07', null, 14);
insert into MealPlan (addDate, allergens, userID) values ('2024-09-30 21:33:41', 'Wheat', 10);
insert into MealPlan (addDate, allergens, userID) values ('2025-03-05 17:00:32', 'Fish', 22);
insert into MealPlan (addDate, allergens, userID) values ('2024-10-05 23:35:13', 'Fish', 24);
insert into MealPlan (addDate, allergens, userID) values ('2024-07-19 05:17:56', null, 30);
insert into MealPlan (addDate, allergens, userID) values ('2024-08-29 08:36:19', null, 21);
insert into MealPlan (addDate, allergens, userID) values ('2024-11-05 16:41:05', null, 20);
insert into MealPlan (addDate, allergens, userID) values ('2024-08-12 00:02:38', 'Gluten', 14);
insert into MealPlan (addDate, allergens, userID) values ('2024-10-10 04:47:13', null, 28);
insert into MealPlan (addDate, allergens, userID) values ('2025-01-10 06:18:03', 'Gluten', 9);
insert into MealPlan (addDate, allergens, userID) values ('2024-11-28 21:05:38', 'Wheat', 26);
insert into MealPlan (addDate, allergens, userID) values ('2024-08-31 13:47:49', 'Soy', 16);
insert into MealPlan (addDate, allergens, userID) values ('2024-04-30 03:36:29', 'Sesame', 30);
insert into MealPlan (addDate, allergens, userID) values ('2024-09-28 14:30:11', null, 27);
insert into MealPlan (addDate, allergens, userID) values ('2025-02-21 18:17:16', null, 19);
insert into MealPlan (addDate, allergens, userID) values ('2024-04-16 06:15:59', null, 4);
insert into MealPlan (addDate, allergens, userID) values ('2025-04-04 10:20:56', null, 15);

-- insert 30 sample meal plan infos
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (1, null, 19);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (2, 'Gluten', 18);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (3, 'Tree nuts', 12);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (4, 'Peanuts', 5);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (5, null, 22);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (6, null, 29);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (7, 'Soy', 27);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (8, null, 17);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (9, 'Fish', 26);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (10, null, 5);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (11, null, 17);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (12, 'Soy', 1);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (13, null, 26);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (14, null, 2);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (15, null, 19);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (16, null, 23);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (17, null, 21);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (18, null, 24);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (19, null, 15);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (20, null, 8);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (21, 'Milk', 1);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (22, null, 7);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (23, null, 30);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (24, 'Peanuts', 14);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (25, 'Milk', 20);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (26, null, 20);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (27, 'Peanuts', 14);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (28, null, 19);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (29, null, 3);
insert into MealPlanInfo (mealPlanInfoID, allergens, recipeID) values (30, 'Fish', 11);

SELECT r.ingredients
        FROM Recipes r
        WHERE r.rating > 7;


-- insert 125 meal plan infos goals  -----
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'vegan');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'quick and easy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (7, 'quick and easy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (23, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'carb-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'kid friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'kid friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'carb-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'balanced');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (7, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'heart healthy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (18, 'carb-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'vegan');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (6, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (3, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'balanced');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'carb-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (16, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'high calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'balanced');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'vegan');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (16, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (23, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'anti-inflammatory');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (12, 'balanced');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'carb-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'heart healthy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (3, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (7, 'meal prep friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (19, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'vegan');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (6, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'kid friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'high calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (6, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'heart healthy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'high calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'quick and easy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'high calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (12, 'fiber rich');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'heart healthy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (1, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (16, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'heart healthy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (1, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'fiber rich');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'fiber rich');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (17, 'kid friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'vegetarian');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'budget friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'heart healthy');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (23, 'high calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (12, 'fat-free');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'high protein');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'low calorie');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'variety');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'kid friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (17, 'fiber rich');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'keto');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'kid friendly');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (18, 'balanced');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'low sodium');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'fiber rich');
insert into MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'fat-free');

-- insert 125 sample recipe_meal plan info
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 6);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 8);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 20);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 15);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 17);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 22);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 13);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 9);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 7);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 28);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 27);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 14);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 6);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (7, 13);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 15);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (10, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 5);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 16);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 23);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 26);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 11);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (9, 10);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 12);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 26);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 28);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 30);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 6);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 15);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (7, 14);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 14);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 27);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 6);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 29);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (10, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 2);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 9);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 16);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 29);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 30);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 20);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (6, 26);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 2);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 11);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 16);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 16);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 29);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 9);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 7);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (3, 20);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 26);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 12);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 24);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 13);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 5);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 11);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 8);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 16);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 27);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 11);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 27);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 29);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 18);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (10, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 2);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 12);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 5);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 6);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 5);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (26, 23);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (1, 3);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (3, 8);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 12);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 10);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 12);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 6);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 27);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 27);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 13);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 20);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (8, 7);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 14);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (6, 25);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 24);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (3, 1);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 2);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 13);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 18);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 8);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 13);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (26, 20);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 19);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 19);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 7);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 26);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 4);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 26);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 15);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 21);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (26, 23);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 24);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 20);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (8, 17);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 24);
insert into Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 9);

-- insert 35 statements into Tags
insert into Tags (tagName, tagID) values ('quick', 1);
insert into Tags (tagName, tagID) values ('low-carb', 2);
insert into Tags (tagName, tagID) values ('quick', 3);
insert into Tags (tagName, tagID) values ('dessert', 4);
insert into Tags (tagName, tagID) values ('budget-friendly', 5);
insert into Tags (tagName, tagID) values ('vegan', 6);
insert into Tags (tagName, tagID) values ('budget-friendly', 7);
insert into Tags (tagName, tagID) values ('comfort food', 8);
insert into Tags (tagName, tagID) values ('quick', 9);
insert into Tags (tagName, tagID) values ('healthy', 10);
insert into Tags (tagName, tagID) values ('paleo', 11);
insert into Tags (tagName, tagID) values ('dessert', 12);
insert into Tags (tagName, tagID) values ('appetizer', 13);
insert into Tags (tagName, tagID) values ('easy', 14);
insert into Tags (tagName, tagID) values ('family-friendly', 15);
insert into Tags (tagName, tagID) values ('vegetarian', 16);
insert into Tags (tagName, tagID) values ('healthy', 17);
insert into Tags (tagName, tagID) values ('low-carb', 18);
insert into Tags (tagName, tagID) values ('family-friendly', 19);
insert into Tags (tagName, tagID) values ('dessert', 20);
insert into Tags (tagName, tagID) values ('comfort food', 21);
insert into Tags (tagName, tagID) values ('vegetarian', 22);
insert into Tags (tagName, tagID) values ('budget-friendly', 23);
insert into Tags (tagName, tagID) values ('dessert', 24);
insert into Tags (tagName, tagID) values ('low-carb', 25);
insert into Tags (tagName, tagID) values ('dessert', 26);
insert into Tags (tagName, tagID) values ('vegetarian', 27);
insert into Tags (tagName, tagID) values ('healthy', 28);
insert into Tags (tagName, tagID) values ('low-carb', 29);
insert into Tags (tagName, tagID) values ('healthy', 30);
insert into Tags (tagName, tagID) values ('dessert', 31);
insert into Tags (tagName, tagID) values ('vegan', 32);
insert into Tags (tagName, tagID) values ('main course', 33);
insert into Tags (tagName, tagID) values ('gluten-free', 34);
insert into Tags (tagName, tagID) values ('quick', 35);

-- insert 130 statements into TagsPosts
insert into tagsPosts (tagID, recipeID) values (26, 14);
insert into tagsPosts (tagID, recipeID) values (24, 3);
insert into tagsPosts (tagID, recipeID) values (19, 9);
insert into tagsPosts (tagID, recipeID) values (29, 21);
insert into tagsPosts (tagID, recipeID) values (3, 23);
insert into tagsPosts (tagID, recipeID) values (16, 18);
insert into tagsPosts (tagID, recipeID) values (30, 3);
insert into tagsPosts (tagID, recipeID) values (4, 21);
insert into tagsPosts (tagID, recipeID) values (8, 19);
insert into tagsPosts (tagID, recipeID) values (28, 24);
insert into tagsPosts (tagID, recipeID) values (13, 18);
insert into tagsPosts (tagID, recipeID) values (28, 12);
insert into tagsPosts (tagID, recipeID) values (9, 6);
insert into tagsPosts (tagID, recipeID) values (27, 20);
insert into tagsPosts (tagID, recipeID) values (10, 15);
insert into tagsPosts (tagID, recipeID) values (29, 27);
insert into tagsPosts (tagID, recipeID) values (18, 13);
insert into tagsPosts (tagID, recipeID) values (28, 5);
insert into tagsPosts (tagID, recipeID) values (21, 9);
insert into tagsPosts (tagID, recipeID) values (4, 30);
insert into tagsPosts (tagID, recipeID) values (6, 10);
insert into tagsPosts (tagID, recipeID) values (29, 20);
insert into tagsPosts (tagID, recipeID) values (21, 2);
insert into tagsPosts (tagID, recipeID) values (25, 23);
insert into tagsPosts (tagID, recipeID) values (11, 16);
insert into tagsPosts (tagID, recipeID) values (24, 15);
insert into tagsPosts (tagID, recipeID) values (6, 2);
insert into tagsPosts (tagID, recipeID) values (15, 24);
insert into tagsPosts (tagID, recipeID) values (5, 23);
insert into tagsPosts (tagID, recipeID) values (9, 22);
insert into tagsPosts (tagID, recipeID) values (18, 25);
insert into tagsPosts (tagID, recipeID) values (2, 13);
insert into tagsPosts (tagID, recipeID) values (10, 15);
insert into tagsPosts (tagID, recipeID) values (18, 30);
insert into tagsPosts (tagID, recipeID) values (19, 23);
insert into tagsPosts (tagID, recipeID) values (28, 7);
insert into tagsPosts (tagID, recipeID) values (16, 9);
insert into tagsPosts (tagID, recipeID) values (10, 28);
insert into tagsPosts (tagID, recipeID) values (8, 17);
insert into tagsPosts (tagID, recipeID) values (13, 29);
insert into tagsPosts (tagID, recipeID) values (13, 10);
insert into tagsPosts (tagID, recipeID) values (25, 30);
insert into tagsPosts (tagID, recipeID) values (29, 26);
insert into tagsPosts (tagID, recipeID) values (4, 6);
insert into tagsPosts (tagID, recipeID) values (6, 13);
insert into tagsPosts (tagID, recipeID) values (30, 26);
insert into tagsPosts (tagID, recipeID) values (23, 9);
insert into tagsPosts (tagID, recipeID) values (12, 25);
insert into tagsPosts (tagID, recipeID) values (1, 27);
insert into tagsPosts (tagID, recipeID) values (29, 29);
insert into tagsPosts (tagID, recipeID) values (18, 30);
insert into tagsPosts (tagID, recipeID) values (23, 27);
insert into tagsPosts (tagID, recipeID) values (30, 23);
insert into tagsPosts (tagID, recipeID) values (21, 13);
insert into tagsPosts (tagID, recipeID) values (27, 13);
insert into tagsPosts (tagID, recipeID) values (17, 16);
insert into tagsPosts (tagID, recipeID) values (19, 19);
insert into tagsPosts (tagID, recipeID) values (30, 1);
insert into tagsPosts (tagID, recipeID) values (15, 8);
insert into tagsPosts (tagID, recipeID) values (1, 19);
insert into tagsPosts (tagID, recipeID) values (19, 1);
insert into tagsPosts (tagID, recipeID) values (26, 19);
insert into tagsPosts (tagID, recipeID) values (21, 29);
insert into tagsPosts (tagID, recipeID) values (30, 16);
insert into tagsPosts (tagID, recipeID) values (6, 29);
insert into tagsPosts (tagID, recipeID) values (15, 9);
insert into tagsPosts (tagID, recipeID) values (16, 4);
insert into tagsPosts (tagID, recipeID) values (3, 22);
insert into tagsPosts (tagID, recipeID) values (26, 28);
insert into tagsPosts (tagID, recipeID) values (9, 14);
insert into tagsPosts (tagID, recipeID) values (17, 5);
insert into tagsPosts (tagID, recipeID) values (23, 23);
insert into tagsPosts (tagID, recipeID) values (20, 15);
insert into tagsPosts (tagID, recipeID) values (12, 2);
insert into tagsPosts (tagID, recipeID) values (4, 30);
insert into tagsPosts (tagID, recipeID) values (5, 3);
insert into tagsPosts (tagID, recipeID) values (10, 8);
insert into tagsPosts (tagID, recipeID) values (7, 25);
insert into tagsPosts (tagID, recipeID) values (19, 17);
insert into tagsPosts (tagID, recipeID) values (14, 1);
insert into tagsPosts (tagID, recipeID) values (20, 10);
insert into tagsPosts (tagID, recipeID) values (15, 17);
insert into tagsPosts (tagID, recipeID) values (2, 30);
insert into tagsPosts (tagID, recipeID) values (6, 14);
insert into tagsPosts (tagID, recipeID) values (1, 10);
insert into tagsPosts (tagID, recipeID) values (1, 26);
insert into tagsPosts (tagID, recipeID) values (22, 27);
insert into tagsPosts (tagID, recipeID) values (16, 19);
insert into tagsPosts (tagID, recipeID) values (19, 5);
insert into tagsPosts (tagID, recipeID) values (1, 28);
insert into tagsPosts (tagID, recipeID) values (1, 5);
insert into tagsPosts (tagID, recipeID) values (29, 6);
insert into tagsPosts (tagID, recipeID) values (12, 4);
insert into tagsPosts (tagID, recipeID) values (27, 28);
insert into tagsPosts (tagID, recipeID) values (6, 30);
insert into tagsPosts (tagID, recipeID) values (3, 6);
insert into tagsPosts (tagID, recipeID) values (26, 18);
insert into tagsPosts (tagID, recipeID) values (9, 29);
insert into tagsPosts (tagID, recipeID) values (2, 16);
insert into tagsPosts (tagID, recipeID) values (17, 18);
insert into tagsPosts (tagID, recipeID) values (25, 6);
insert into tagsPosts (tagID, recipeID) values (9, 22);
insert into tagsPosts (tagID, recipeID) values (23, 6);
insert into tagsPosts (tagID, recipeID) values (24, 1);
insert into tagsPosts (tagID, recipeID) values (2, 5);
insert into tagsPosts (tagID, recipeID) values (12, 17);
insert into tagsPosts (tagID, recipeID) values (14, 7);
insert into tagsPosts (tagID, recipeID) values (9, 14);
insert into tagsPosts (tagID, recipeID) values (27, 30);
insert into tagsPosts (tagID, recipeID) values (9, 5);
insert into tagsPosts (tagID, recipeID) values (9, 13);
insert into tagsPosts (tagID, recipeID) values (11, 5);
insert into tagsPosts (tagID, recipeID) values (28, 27);
insert into tagsPosts (tagID, recipeID) values (22, 23);
insert into tagsPosts (tagID, recipeID) values (4, 8);
insert into tagsPosts (tagID, recipeID) values (6, 27);
insert into tagsPosts (tagID, recipeID) values (9, 15);
insert into tagsPosts (tagID, recipeID) values (4, 9);
insert into tagsPosts (tagID, recipeID) values (1, 23);
insert into tagsPosts (tagID, recipeID) values (19, 21);
insert into tagsPosts (tagID, recipeID) values (16, 10);
insert into tagsPosts (tagID, recipeID) values (18, 10);
insert into tagsPosts (tagID, recipeID) values (12, 8);
insert into tagsPosts (tagID, recipeID) values (6, 23);
insert into tagsPosts (tagID, recipeID) values (12, 1);
insert into tagsPosts (tagID, recipeID) values (20, 15);
insert into tagsPosts (tagID, recipeID) values (14, 17);
insert into tagsPosts (tagID, recipeID) values (12, 13);
insert into tagsPosts (tagID, recipeID) values (24, 5);
insert into tagsPosts (tagID, recipeID) values (14, 24);

-- insert 130 statements into MealPlan_goals 
insert into MealPlan_goals (mealPlanId, goals) values (17, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (21, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (24, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (19, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (12, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (8, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (6, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (11, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (23, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (2, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (13, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (13, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (6, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (6, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (12, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (17, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (11, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (26, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (4, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (6, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (26, 'increase protein consumption');
insert into MealPlan_goals (mealPlanId, goals) values (8, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (10, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (18, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (21, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (30, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (19, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (8, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (12, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (9, 'increase protein consumption');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (10, 'increase protein consumption');
insert into MealPlan_goals (mealPlanId, goals) values (14, 'increase protein consumption');
insert into MealPlan_goals (mealPlanId, goals) values (19, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (24, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (26, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (8, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (20, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'increase protein consumption');
insert into MealPlan_goals (mealPlanId, goals) values (10, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (2, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (13, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (20, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (15, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (15, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (11, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (19, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (14, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (28, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (24, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (21, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (12, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (15, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (14, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (11, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (13, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (4, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (5, 'drink more water');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (18, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (4, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (23, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (9, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (21, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (16, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (15, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (30, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (13, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (29, 'increase protein consumption');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (29, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (22, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (15, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (10, 'mindful eating');
insert into MealPlan_goals (mealPlanId, goals) values (30, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (6, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (3, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (21, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (28, 'meal prep');
insert into MealPlan_goals (mealPlanId, goals) values (17, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (4, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (21, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (26, 'limit processed foods');
insert into MealPlan_goals (mealPlanId, goals) values (15, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (1, 'limit caffeine intake');
insert into MealPlan_goals (mealPlanId, goals) values (27, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (20, 'reduce sugar intake');
insert into MealPlan_goals (mealPlanId, goals) values (25, 'balanced meals');
insert into MealPlan_goals (mealPlanId, goals) values (25, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (26, 'portion control');
insert into MealPlan_goals (mealPlanId, goals) values (24, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (7, 'eat more vegetables');
insert into MealPlan_goals (mealPlanId, goals) values (11, 'balanced meals');

-- insert 60 statements into UserDemographics 
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (28.4, 'Male', 0.33, 0.85, 1, 9);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (45.1, 'Female', 0.42, 0.77, 2, 2);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (34.7, 'Female', 0.56, 0.67, 3, 14);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (21.2, 'Male', 0.13, 0.34, 4, 25);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (30.8, 'Female', 0.47, 0.92, 5, 7);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (39.0, 'Male', 0.61, 0.43, 6, 17);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (26.4, 'Male', 0.74, 0.58, 7, 13);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (48.2, 'Female', 0.29, 0.73, 8, 6);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (23.3, 'Male', 0.21, 0.38, 9, 19);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (32.1, 'Female', 0.67, 0.59, 10, 4);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (44.6, 'Female', 0.39, 0.25, 11, 23);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (36.5, 'Male', 0.53, 0.79, 12, 11);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (20.1, 'Female', 0.19, 0.62, 13, 3);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (27.9, 'Male', 0.82, 0.71, 14, 8);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (38.6, 'Female', 0.31, 0.66, 15, 1);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (49.5, 'Male', 0.25, 0.44, 16, 21);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (29.7, 'Female', 0.73, 0.88, 17, 30);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (31.6, 'Male', 0.62, 0.51, 18, 10);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (22.4, 'Female', 0.15, 0.93, 19, 16);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (40.3, 'Male', 0.45, 0.48, 20, 5);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (33.5, 'Female', 0.37, 0.79, 21, 12);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (24.9, 'Male', 0.88, 0.91, 22, 28);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (37.4, 'Female', 0.49, 0.64, 23, 26);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (42.2, 'Male', 0.22, 0.19, 24, 18);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (35.1, 'Female', 0.66, 0.31, 25, 27);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (47.8, 'Male', 0.36, 0.83, 26, 20);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (25.3, 'Female', 0.55, 0.74, 27, 15);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (30.2, 'Male', 0.69, 0.89, 28, 24);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (43.9, 'Female', 0.48, 0.54, 29, 22);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (21.8, 'Male', 0.12, 0.39, 30, 29);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (46.2, 'Female', 0.27, 0.51, 31, 3);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (37.8, 'Male', 0.64, 0.77, 32, 7);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (23.1, 'Female', 0.10, 0.96, 33, 1);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (41.7, 'Male', 0.58, 0.42, 34, 16);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (29.3, 'Female', 0.43, 0.71, 35, 11);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (35.8, 'Male', 0.70, 0.63, 36, 9);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (27.4, 'Female', 0.35, 0.85, 37, 13);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (50.0, 'Male', 0.60, 0.78, 38, 4);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (22.7, 'Female', 0.18, 0.90, 39, 6);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (36.3, 'Male', 0.49, 0.67, 40, 14);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (39.5, 'Female', 0.51, 0.58, 41, 2);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (26.9, 'Male', 0.76, 0.93, 42, 5);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (30.6, 'Female', 0.59, 0.62, 43, 8);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (44.2, 'Male', 0.41, 0.33, 44, 10);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (31.9, 'Female', 0.38, 0.72, 45, 17);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (28.5, 'Male', 0.63, 0.87, 46, 12);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (33.2, 'Female', 0.30, 0.40, 47, 19);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (42.6, 'Male', 0.55, 0.79, 48, 18);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (25.7, 'Female', 0.67, 0.60, 49, 15);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (38.1, 'Male', 0.50, 0.52, 50, 20);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (34.9, 'Female', 0.44, 0.36, 51, 22);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (40.8, 'Male', 0.46, 0.81, 52, 23);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (32.8, 'Female', 0.72, 0.86, 53, 24);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (27.6, 'Male', 0.39, 0.66, 54, 26);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (46.7, 'Female', 0.26, 0.45, 55, 27);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (22.1, 'Male', 0.14, 0.97, 56, 28);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (29.0, 'Female', 0.52, 0.50, 57, 29);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (35.6, 'Male', 0.71, 0.75, 58, 30);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (31.0, 'Female', 0.40, 0.61, 59, 21);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demographicID, demUserID) VALUES (43.1, 'Male', 0.57, 0.69, 60, 25);
