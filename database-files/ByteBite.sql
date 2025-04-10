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
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (1, '2025-02-17 18:21:31', 'Tree nuts', 22);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (2, '2024-10-31 18:21:31', null, 14);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (3, '2025-02-18 14:33:13', 'Peanuts', 24);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (4, '2024-12-06 08:39:02', 'Gluten', 2);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (5, '2024-12-15 20:58:50', null, 24);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (6, '2024-12-11 21:02:26', null, 19);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (7, '2024-12-08 16:27:37', null, 8);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (8, '2024-04-12 04:17:26', 'Wheat', 22);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (9, '2024-09-12 14:20:29', null, 21);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (10, '2024-05-24 13:11:14', 'Wheat', 9);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (11, '2024-05-24 23:17:23', null, 28);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (12, '2025-02-08 21:07:55', 'Gluten', 21);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (13, '2025-03-13 14:26:41', 'Tree nuts', 7);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (14, '2024-06-14 20:22:07', null, 14);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (15, '2024-09-30 21:33:41', 'Wheat', 10);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (16, '2025-03-05 17:00:32', 'Fish', 22);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (17, '2024-10-05 23:35:13', 'Fish', 24);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (18, '2024-07-19 05:17:56', null, 30);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (19, '2024-08-29 08:36:19', null, 21);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (20, '2024-11-05 16:41:05', null, 20);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (21, '2024-08-12 00:02:38', 'Gluten', 14);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (22, '2024-10-10 04:47:13', null, 28);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (23, '2025-01-10 06:18:03', 'Gluten', 9);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (24, '2024-11-28 21:05:38', 'Wheat', 26);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (25, '2024-08-31 13:47:49', 'Soy', 16);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (26, '2024-04-30 03:36:29', 'Sesame', 30);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (27, '2024-09-28 14:30:11', null, 27);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (28, '2025-02-21 18:17:16', null, 19);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (29, '2024-04-16 06:15:59', null, 4);
insert into MealPlan (mealPlanId, addDate, allergens, userID) values (30, '2025-04-04 10:20:56', null, 15);


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

