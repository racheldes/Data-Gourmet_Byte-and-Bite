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
  userinfoID int AUTO_INCREMENT NOT NULL,
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
  demographicID int AUTO_INCREMENT NOT NULL,
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
  reportID int AUTO_INCREMENT NOT NULL PRIMARY KEY,
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

-- create report management table
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


-- INSERTION STATEMENTS

-- insert 40 rows into users
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (1, 'user1', 53, 'Male', 'user', 'Lake Anthonybury', 'user1@example.com', '($h26Msz*Q');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (2, 'user2', 59, 'Male', 'user', 'Daleton', 'user2@example.com', '@d0YDXzzL6');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (3, 'user3', 33, 'Female', 'nutritionist', 'New Morgan', 'user3@example.com', 'kl4OLrmY_A');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (4, 'user4', 49, 'Prefer not to say', 'data analyst', 'North Crystalside', 'user4@example.com', '(s(8qSIzY(');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (5, 'user5', 43, 'Male', 'data analyst', 'Obrienview', 'user5@example.com', '8&8KduKbB#');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (6, 'user6', 42, 'Male', 'nutritionist', 'East Shellyburgh', 'user6@example.com', '&9ppbJpc@R');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (7, 'user7', 34, 'Prefer not to say', 'app manager', 'Perkinsside', 'user7@example.com', '$pkW1RVr6Z');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (8, 'user8', 45, 'Prefer not to say', 'data analyst', 'New Sarahshire', 'user8@example.com', 'rjkRUlMc+2');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (9, 'user9', 30, 'Non-binary', 'data analyst', 'West Laurieborough', 'user9@example.com', '_4EQ9JQr6W');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (10, 'user10', 21, 'Male', 'app manager', 'Whitehaven', 'user10@example.com', 'f2$G6Ij7$Z');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (11, 'user11', 21, 'Male', 'nutritionist', 'Wrighttown', 'user11@example.com', '84Xlx4Wf*O');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (12, 'user12', 50, 'Female', 'user', 'Cassandraside', 'user12@example.com', '7(587+Yj)G');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (13, 'user13', 50, 'Male', 'data analyst', 'Lake Ashleyshire', 'user13@example.com', 'm%RatQz$^1');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (14, 'user14', 22, 'Male', 'data analyst', 'East Thomasberg', 'user14@example.com', 'qC2DuHkc#x');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (15, 'user15', 43, 'Male', 'data analyst', 'Brownview', 'user15@example.com', 'S#c3SjfWWe');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (16, 'user16', 55, 'Male', 'user', 'South Kayla', 'user16@example.com', '&dFNlolTL2');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (17, 'user17', 44, 'Non-binary', 'app manager', 'West Michaelland', 'user17@example.com', 'ey5B8U!3#0');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (18, 'user18', 31, 'Non-binary', 'data analyst', 'New Crystalshire', 'user18@example.com', '%)2Tx2Bd4v');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (19, 'user19', 34, 'Prefer not to say', 'data analyst', 'Quinnfort', 'user19@example.com', 'T^1r1REdzv');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (20, 'user20', 60, 'Non-binary', 'nutritionist', 'Port Joel', 'user20@example.com', 'iE3BFRoRA_');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (21, 'user21', 38, 'Male', 'user', 'Jessicatown', 'user21@example.com', '$C354QZz!y');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (22, 'user22', 47, 'Male', 'user', 'East Carly', 'user22@example.com', '!7g2OsOtK*');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (23, 'user23', 52, 'Female', 'app manager', 'Barbaraside', 'user23@example.com', 'ur*s5Uv$yQ');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (24, 'user24', 26, 'Non-binary', 'user', 'Mitchellmouth', 'user24@example.com', 'S!vI6GlaWB');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (25, 'user25', 33, 'Non-binary', 'app manager', 'South Keithfurt', 'user25@example.com', '&do7T2y1SH');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (26, 'user26', 28, 'Prefer not to say', 'app manager', 'Buckleymouth', 'user26@example.com', '_U1TFUgMYW');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (27, 'user27', 57, 'Male', 'app manager', 'Johnside', 'user27@example.com', 'zp+8FJ%cFP');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (28, 'user28', 60, 'Male', 'data analyst', 'Port Natashaside', 'user28@example.com', 'n1SmfUPr&D');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (29, 'user29', 34, 'Male', 'user', 'Snyderborough', 'user29@example.com', 'dy+f_2TaI&');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (30, 'user30', 65, 'Female', 'app manager', 'North Douglas', 'user30@example.com', 'A53k2ZDcD@');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (31, 'user31', 36, 'Female', 'app manager', 'Douglasmouth', 'user31@example.com', 'INI29UKd#W');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (32, 'user32', 31, 'Non-binary', 'nutritionist', 'Lake Maria', 'user32@example.com', 'd%X5WDq(pb');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (33, 'user33', 34, 'Male', 'user', 'East Matthew', 'user33@example.com', 'E*(9KFs@R3');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (34, 'user34', 58, 'Prefer not to say', 'app manager', 'New Sheila', 'user34@example.com', '&S7AvwXvb%');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (35, 'user35', 20, 'Male', 'app manager', 'East Melissaborough', 'user35@example.com', 'j+8ONukq+d');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (36, 'user36', 26, 'Non-binary', 'data analyst', 'Kaylafurt', 'user36@example.com', '+3it#qPm#T');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (37, 'user37', 65, 'Prefer not to say', 'nutritionist', 'Lake Annetteport', 'user37@example.com', '_%5ZyWBlT0');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (38, 'user38', 53, 'Male', 'user', 'South Kristamouth', 'user38@example.com', ')XUxFj!y61');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (39, 'user39', 22, 'Female', 'user', 'Sandramouth', 'user39@example.com', '+00G97iMuA');
INSERT INTO Users (userID, username, age, gender, role, location, email, password) VALUES (40, 'user40', 41, 'Female', 'nutritionist', 'South Melissa', 'user40@example.com', 'MV@88KPxe4');



-- insert 40 recipes
INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (1, 'chef_john', 4.5, '2025-04-09', '2 cups of flour, 1/2 cup of sugar, 1 tsp of baking powder, 1/4 tsp of salt, 1/2 cup of milk, 1/2 cup of butter, 1 egg, 1 tsp vanilla extract', 'Preheat the oven to 350°F. In a bowl, mix all dry ingredients. Add wet ingredients and mix until smooth. Pour into a greased pan and bake for 30 minutes.', 'Gluten, Dairy, Eggs', 1);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (2, 'baker_ella', 5.0, '2025-04-07', '1 1/2 cups of whole wheat flour, 3/4 cup of honey, 1/4 cup of coconut oil, 1 tsp of cinnamon, 1/2 tsp of nutmeg, 1 egg, 1/2 cup of chopped walnuts', 'Mix all dry ingredients in a bowl. In a separate bowl, combine wet ingredients and mix until smooth. Fold in walnuts, pour batter into a loaf pan, and bake at 325°F for 40 minutes.', 'Gluten, Nuts', 2);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (3, 'vegan_vicky', 4.8, '2025-04-05', '1 cup of quinoa, 2 cups of vegetable broth, 1/2 cup of diced tomatoes, 1/4 cup of chopped cilantro, 1 tsp of cumin, 1 tbsp of olive oil, 1 lime', 'Rinse the quinoa under cold water. In a pot, combine vegetable broth, tomatoes, and cumin, and bring to a boil. Add quinoa, reduce heat, cover, and simmer for 15 minutes. Garnish with cilantro and lime before serving.', 'None', 3);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (4, 'chef_susan', 3.7, '2025-03-30', '1 lb of chicken breast, 2 cups of broccoli florets, 1/2 cup of soy sauce, 1 tbsp of honey, 1 tbsp of olive oil, 1 tsp of garlic powder, 1/2 tsp of chili flakes', 'Cook the chicken in olive oil until browned. Add soy sauce, honey, and garlic powder, and simmer for 5 minutes. Add broccoli and cook until tender. Serve with rice.', 'Soy', 4);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (5, 'sweet_tooth_tina', 4.9, '2025-04-01', '1 cup of dark chocolate chips, 1/2 cup of heavy cream, 1/4 cup of sugar, 1/2 tsp of vanilla extract, 1 tbsp of sea salt', 'In a saucepan, heat cream and sugar until just boiling. Remove from heat, add chocolate chips, and stir until smooth. Add vanilla extract. Pour into molds, sprinkle with sea salt, and refrigerate for 2 hours.', 'Dairy', 5);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (6, 'kitchen_queen', 4.3, '2025-03-25', '2 cups of rice, 4 cups of chicken broth, 1/2 cup of peas, 1/4 cup of carrots, 1 tbsp of butter, 1 tsp of thyme', 'In a pot, heat chicken broth. Add rice, cover, and cook for 20 minutes. Stir in peas, carrots, butter, and thyme. Cook for an additional 5 minutes.', 'None', 6);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (7, 'grill_master', 4.7, '2025-03-28', '1 lb of beef steaks, 2 tbsp of olive oil, 2 tbsp of soy sauce, 1 tbsp of garlic powder, 1 tbsp of paprika', 'Marinate steaks in olive oil, soy sauce, garlic powder, and paprika for 30 minutes. Grill on medium-high heat for 5-6 minutes per side.', 'Soy', 7);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (8, 'soup_chef', 4.6, '2025-03-20', '3 cups of chicken broth, 1 cup of chopped potatoes, 1 cup of sliced carrots, 1/2 cup of celery, 1 tbsp of olive oil, 1 tsp of thyme', 'In a pot, sauté olive oil, carrots, and celery for 5 minutes. Add chicken broth, potatoes, and thyme. Simmer for 20 minutes until vegetables are tender.', 'None', 8);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (9, 'sushimaster', 5.0, '2025-03-18', '2 cups of sushi rice, 1/4 cup of rice vinegar, 10 sheets of nori, 1 cucumber, 1 avocado, 1/2 lb of sushi-grade tuna', 'Cook sushi rice and season with rice vinegar. Slice cucumber, avocado, and tuna. Assemble sushi rolls using nori, rice, and fillings. Slice and serve.', 'Fish', 9);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (10, 'italian_mama', 4.4, '2025-03-15', '1 lb of spaghetti, 1/2 cup of olive oil, 4 cloves of garlic, 1 can of crushed tomatoes, 1/4 cup of fresh basil, 1/2 tsp of red pepper flakes', 'Cook spaghetti according to package instructions. In a pan, heat olive oil and sauté garlic. Add crushed tomatoes, basil, and red pepper flakes. Toss cooked spaghetti with sauce.', 'Gluten', 10);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (11, 'smoothie_boss', 4.8, '2025-03-10', '1 banana, 1/2 cup of spinach, 1/2 cup of almond milk, 1 tbsp of peanut butter, 1 tbsp of honey', 'Blend all ingredients until smooth. Serve immediately.', 'Peanuts', 11);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (12, 'quick_and_easy', 4.3, '2025-03-02', '1 package of instant noodles, 2 cups of water, 1 tbsp of soy sauce, 1 boiled egg', 'Cook noodles according to package instructions. Add soy sauce and a boiled egg on top.', 'Soy', 12);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (13, 'chef_emily', 4.9, '2025-02-25', '1 lb of shrimp, 1 cup of rice, 1/2 cup of bell peppers, 1 tbsp of garlic, 1 tbsp of soy sauce, 1 tbsp of olive oil', 'Sauté garlic in olive oil, add shrimp and bell peppers. Cook for 5-7 minutes. Serve with rice and soy sauce.', 'Shellfish, Soy', 13);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (14, 'veggie_lovers', 4.5, '2025-02-18', '1 cup of quinoa, 2 cups of vegetable broth, 1/2 cup of diced bell peppers, 1 tbsp of olive oil, 1/2 cup of corn', 'Cook quinoa in vegetable broth for 15 minutes. Stir in bell peppers, corn, and olive oil. Serve hot.', 'None', 14);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (15, 'bread_baker', 4.6, '2025-02-10', '3 cups of flour, 1 tsp of yeast, 1 tbsp of sugar, 1/2 cup of water, 1/4 cup of olive oil, 1 tsp of salt', 'Mix flour, yeast, sugar, and salt. Gradually add water and oil. Knead dough, let rise for an hour, and bake at 375°F for 25 minutes.', 'Gluten', 15);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (16, 'fitness_fanatic', 4.2, '2025-02-03', '1 cup of oats, 1/2 cup of almond milk, 1/4 cup of chia seeds, 1/2 cup of strawberries, 1 tbsp of honey', 'Mix oats, almond milk, chia seeds, and honey in a jar. Refrigerate overnight. Top with strawberries before serving.', 'Nuts', 16);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (17, 'grill_queen', 4.5, '2025-01-30', '1 lb of pork ribs, 1/2 cup of BBQ sauce, 1 tbsp of olive oil, 1 tbsp of paprika, 1 tsp of garlic powder', 'Rub ribs with olive oil, paprika, garlic powder, and BBQ sauce. Grill on medium heat for 30-40 minutes.', 'None', 17);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (18, 'comfort_foodie', 4.0, '2025-01-25', '2 cups of mashed potatoes, 1 cup of heavy cream, 1/4 cup of butter, 1/2 tsp of garlic powder, 1/2 tsp of salt', 'Heat mashed potatoes with heavy cream, butter, and garlic powder until smooth. Serve hot.', 'Dairy', 18);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (19, 'pasta_lover', 5.0, '2025-01-20', '1 lb of pasta, 1/4 cup of pesto, 1/2 cup of cherry tomatoes, 1 tbsp of parmesan', 'Cook pasta according to package instructions. Toss with pesto, cherry tomatoes, and parmesan.', 'Gluten, Dairy', 19);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (20, 'breakfast_boss', 4.7, '2025-01-15', '2 eggs, 1 tbsp of olive oil, 1/4 cup of spinach, 1/4 cup of cheese', 'Scramble eggs in olive oil. Add spinach and cheese, and cook until cheese is melted.', 'Dairy', 20);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (21, 'chef_lucy', 4.3, '2025-01-10', '2 cups of flour, 1 cup of sugar, 1/2 cup of cocoa powder, 1 tsp of baking soda, 1/4 tsp of salt, 1/2 cup of vegetable oil, 1 tsp of vanilla extract', 'Preheat oven to 350°F. In a bowl, combine dry ingredients. Add wet ingredients and mix. Pour into a greased pan and bake for 35 minutes.', 'Gluten, Dairy', 21);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (22, 'spicy_susan', 4.4, '2025-01-05', '1 lb of ground beef, 1 onion, 2 cloves garlic, 1 can of diced tomatoes, 1 can of chili beans, 1 tbsp of chili powder', 'Brown beef with onion and garlic. Add tomatoes, beans, and chili powder. Simmer for 30 minutes.', 'None', 22);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (23, 'bake_master', 4.5, '2025-01-02', '2 cups of flour, 1/2 cup of sugar, 1 cup of butter, 1 egg, 1 tsp of vanilla extract', 'Mix butter and sugar. Add egg and vanilla, then flour. Roll dough and bake at 350°F for 10 minutes.', 'Gluten, Dairy, Eggs', 23);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (24, 'the_pasta_guru', 5.0, '2024-12-30', '1 lb of spaghetti, 2 cups of marinara sauce, 1 tbsp of olive oil, 1/2 cup of parmesan', 'Cook pasta according to package instructions. Heat marinara sauce and toss with pasta. Serve with parmesan.', 'Gluten, Dairy', 24);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (25, 'smoothie_queen', 4.7, '2024-12-28', '1/2 cup of almond milk, 1 banana, 1/2 cup of strawberries, 1 tbsp of chia seeds', 'Blend all ingredients until smooth. Serve immediately.', 'Nuts', 25);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (26, 'healthy_eats', 4.6, '2024-12-20', '1 cup of quinoa, 1/2 cup of cucumber, 1/4 cup of red onion, 2 tbsp of olive oil, 1 tbsp of lemon juice', 'Cook quinoa. Combine with chopped cucumber, onion, olive oil, and lemon juice. Chill before serving.', 'None', 26);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (27, 'dessert_king', 5.0, '2024-12-18', '2 cups of heavy cream, 1 cup of sugar, 1 tsp vanilla extract', 'Whisk cream and sugar over heat until sugar dissolves. Add vanilla and chill. Serve as a whipped topping.', 'Dairy', 27);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (28, 'burrito_boss', 4.8, '2024-12-12', '1 lb of ground turkey, 1 can of black beans, 1 cup of cooked rice, 1 tbsp of cumin, 1 tbsp of chili powder, 4 flour tortillas', 'Cook ground turkey with spices. Add black beans and rice, mix. Wrap in tortillas and bake at 350°F for 20 minutes.', 'Gluten', 28);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (29, 'salad_specialist', 4.3, '2024-12-05', '2 cups of lettuce, 1/2 cup of tomatoes, 1/4 cup of feta, 1 tbsp of olive oil, 1 tbsp of balsamic vinegar', 'Toss all ingredients in a bowl. Serve immediately.', 'Dairy', 29);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (30, 'brunch_lover', 4.6, '2024-12-01', '2 cups of flour, 1/2 cup of milk, 1 egg, 1 tbsp of sugar, 1 tsp of vanilla extract', 'Whisk all ingredients together and cook on a griddle. Serve with syrup.', 'Gluten, Dairy, Eggs', 30);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (31, 'bbq_boss', 4.7, '2024-11-28', '2 racks of ribs, 1 cup of BBQ sauce, 1 tsp of paprika, 1 tsp of garlic powder, 1 tsp of onion powder', 'Rub ribs with spices. Grill on medium heat for 2 hours, basting with BBQ sauce.', 'None', 31);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (32, 'soup_lover', 4.5, '2024-11-20', '1 lb of butternut squash, 4 cups of vegetable broth, 1 onion, 1 tbsp of olive oil', 'Cook onion in olive oil, then add butternut squash and vegetable broth. Simmer for 30 minutes, blend until smooth.', 'None', 32);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (33, 'quick_bites', 4.2, '2024-11-15', '1 package of instant noodles, 2 cups of water, 1 tbsp of soy sauce', 'Cook noodles according to package instructions. Add soy sauce and serve.', 'Soy', 33);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (34, 'italian_dream', 4.9, '2024-11-10', '1 lb of ground beef, 1 cup of bread crumbs, 1 egg, 1/2 cup of parmesan, 1 tbsp of parsley', 'Mix ingredients and form meatballs. Bake at 375°F for 20 minutes.', 'Gluten, Dairy, Eggs', 34);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (35, 'vegan_power', 4.6, '2024-11-05', '1 cup of lentils, 4 cups of vegetable broth, 1 onion, 1 tbsp of cumin', 'Cook lentils in vegetable broth with onion and cumin for 30 minutes. Serve hot.', 'None', 35);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (36, 'bakery_chef', 4.3, '2024-11-01', '2 cups of flour, 1/2 cup of sugar, 1/2 cup of butter, 1 egg', 'Mix ingredients together and bake at 350°F for 25 minutes.', 'Gluten, Dairy, Eggs', 36);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (37, 'cooking_mom', 4.4, '2024-10-28', '1 lb of chicken breast, 2 cups of spinach, 1 tbsp of garlic, 1 tbsp of olive oil', 'Cook chicken in olive oil with garlic, then add spinach. Serve with rice.', 'None', 37);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (38, 'salad_guru', 4.7, '2024-10-25', '2 cups of kale, 1/2 cup of walnuts, 1/4 cup of feta, 1 tbsp of balsamic vinegar', 'Toss all ingredients in a bowl and serve immediately.', 'Nuts, Dairy', 38);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (39, 'smoothie_addict', 4.8, '2024-10-20', '1/2 cup of frozen blueberries, 1 banana, 1/2 cup of almond milk, 1 tbsp of flaxseeds', 'Blend ingredients together and serve.', 'Nuts', 39);

INSERT INTO Recipes (recipeID, username, rating, date, ingredients, directions, allergens, recipeUserID)
VALUES (40, 'comfort_kitchen', 4.5, '2024-10-15', '2 cups of mashed potatoes, 1/2 cup of cheese, 1/4 cup of butter', 'Mix mashed potatoes with cheese and butter. Serve warm.', 'Dairy', 40);


-- insert 35 reviews without explicitly inserting review_id
-- insert 35 reviews
INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (1, 'Delicious cake! The texture was perfect, though I would add a bit more vanilla extract next time.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (2, 'The bread came out great! The honey and walnuts gave it a perfect flavor balance.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (3, 'Tasty and healthy! Love the quinoa base and the freshness from the cilantro. Perfect vegan meal.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (4, 'The chicken was a little dry, but the sauce was nice. Could use more flavor overall.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (5, 'These chocolates were amazing! Just the right amount of sweetness, and the sea salt was a nice touch.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (6, 'Very simple and quick, but a little bland for my taste. I added more herbs and it was much better.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (7, 'The ribs turned out perfectly! A little more BBQ sauce would have made it even better.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (8, 'A lovely and comforting soup, just like mom used to make. I added some garlic bread on the side for extra flavor.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (9, 'Fantastic sushi! The rice was just right, and the fish was fresh. Definitely making this again!', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (10, 'Classic Italian spaghetti with a delicious sauce. It could use a bit more garlic for my liking.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (11, 'The perfect smoothie. The banana and peanut butter were a great combo. I loved it!', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (12, 'A quick and easy meal. Perfect for busy days, but the flavor was a bit basic for me.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (13, 'This shrimp recipe was delicious! The garlic and bell peppers really brought it together.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (14, 'Nice and light dish, but could use a bit more seasoning to make the quinoa more flavorful.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (15, 'Great bread, nice texture, though I think it could have been a little fluffier.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (16, 'A good breakfast option. The chia seeds were a nice touch, but it was a bit too sweet for my taste.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (17, 'These ribs were amazing, juicy and full of flavor. The BBQ sauce really made them stand out.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (18, 'Simple and tasty mashed potatoes, but could use more seasoning or cheese for added richness.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (19, 'A good salsa, fresh flavors, but it could have been spicier for my liking.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (20, 'Loved this pasta dish! The garlic and olive oil made it perfect. I’ll definitely make this again.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (21, 'The cookies were really tasty! Could use a little less sugar next time, though.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (22, 'Amazing flavor on the chicken, I loved the spice mix. It was the perfect level of heat!', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (23, 'Delicious sushi! Loved the fresh salmon. Would make it more often if I had the time!', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (24, 'The meatballs were nice, but they could be a little juicier. Still, a great classic dish.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (25, 'Such a refreshing smoothie! The oats gave it a great texture, and the banana added sweetness.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (26, 'A simple meal that did the job. Could use a little more seasoning to make it tastier.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (27, 'The salmon was perfectly cooked! It was flaky and juicy, and the honey-mustard glaze was delicious.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (28, 'A refreshing and healthy salad! I added some feta cheese for extra flavor.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (29, 'Great protein-packed meal! The chicken and quinoa were a perfect match. I would add some more veggies next time.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (30, 'A comforting treat. The texture was perfect, but I think I’d add some cinnamon next time for extra flavor.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (31, 'Amazing taco filling! The beef was flavorful and tender. I’d add some jalapeños next time for extra heat.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (32, 'This was a fantastic way to prepare salmon. The glaze was delicious, and the fish was perfectly cooked.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (33, 'A great vegetarian option, but the quinoa could use more seasoning. The spinach was a nice touch.', 4);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (34, 'Such a refreshing fruit salad! Loved the watermelon and pineapple mix.', 5);

INSERT INTO Reviews (reviewUserID, comment, rating)
VALUES (35, 'These chocolates were heavenly! The perfect combination of sweetness and bitterness from the dark chocolate.', 5);


-- insert 35 statements into Tags
INSERT INTO  Tags (tagName, tagID) values ('quick', 1);
INSERT INTO  Tags (tagName, tagID) values ('low-carb', 2);
INSERT INTO  Tags (tagName, tagID) values ('quick', 3);
INSERT INTO  Tags (tagName, tagID) values ('dessert', 4);
INSERT INTO  Tags (tagName, tagID) values ('budget-friendly', 5);
INSERT INTO  Tags (tagName, tagID) values ('vegan', 6);
INSERT INTO  Tags (tagName, tagID) values ('budget-friendly', 7);
INSERT INTO  Tags (tagName, tagID) values ('comfort food', 8);
INSERT INTO  Tags (tagName, tagID) values ('quick', 9);
INSERT INTO  Tags (tagName, tagID) values ('healthy', 10);
INSERT INTO  Tags (tagName, tagID) values ('paleo', 11);
INSERT INTO  Tags (tagName, tagID) values ('dessert', 12);
INSERT INTO  Tags (tagName, tagID) values ('appetizer', 13);
INSERT INTO  Tags (tagName, tagID) values ('easy', 14);
INSERT INTO  Tags (tagName, tagID) values ('family-friendly', 15);
INSERT INTO  Tags (tagName, tagID) values ('vegetarian', 16);
INSERT INTO  Tags (tagName, tagID) values ('healthy', 17);
INSERT INTO  Tags (tagName, tagID) values ('low-carb', 18);
INSERT INTO  Tags (tagName, tagID) values ('family-friendly', 19);
INSERT INTO  Tags (tagName, tagID) values ('dessert', 20);
INSERT INTO  Tags (tagName, tagID) values ('comfort food', 21);
INSERT INTO  Tags (tagName, tagID) values ('vegetarian', 22);
INSERT INTO  Tags (tagName, tagID) values ('budget-friendly', 23);
INSERT INTO  Tags (tagName, tagID) values ('dessert', 24);
INSERT INTO  Tags (tagName, tagID) values ('low-carb', 25);
INSERT INTO  Tags (tagName, tagID) values ('dessert', 26);
INSERT INTO  Tags (tagName, tagID) values ('vegetarian', 27);
INSERT INTO  Tags (tagName, tagID) values ('healthy', 28);
INSERT INTO  Tags (tagName, tagID) values ('low-carb', 29);
INSERT INTO  Tags (tagName, tagID) values ('healthy', 30);
INSERT INTO  Tags (tagName, tagID) values ('dessert', 31);
INSERT INTO  Tags (tagName, tagID) values ('vegan', 32);
INSERT INTO  Tags (tagName, tagID) values ('main course', 33);
INSERT INTO  Tags (tagName, tagID) values ('gluten-free', 34);
INSERT INTO  Tags (tagName, tagID) values ('quick', 35);


-- insert 130 statements into TagsPosts
INSERT INTO  tagsPosts (tagID, recipeID) values (26, 14);
INSERT INTO  tagsPosts (tagID, recipeID) values (24, 3);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 9);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 21);
INSERT INTO  tagsPosts (tagID, recipeID) values (3, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (16, 18);
INSERT INTO  tagsPosts (tagID, recipeID) values (30, 3);
INSERT INTO  tagsPosts (tagID, recipeID) values (4, 21);
INSERT INTO  tagsPosts (tagID, recipeID) values (8, 19);
INSERT INTO  tagsPosts (tagID, recipeID) values (28, 24);
INSERT INTO  tagsPosts (tagID, recipeID) values (13, 18);
INSERT INTO  tagsPosts (tagID, recipeID) values (28, 12);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 6);
INSERT INTO  tagsPosts (tagID, recipeID) values (27, 20);
INSERT INTO  tagsPosts (tagID, recipeID) values (10, 15);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 27);
INSERT INTO  tagsPosts (tagID, recipeID) values (18, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (28, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (21, 9);
INSERT INTO  tagsPosts (tagID, recipeID) values (4, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 10);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 20);
INSERT INTO  tagsPosts (tagID, recipeID) values (21, 2);
INSERT INTO  tagsPosts (tagID, recipeID) values (25, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (11, 16);
INSERT INTO  tagsPosts (tagID, recipeID) values (24, 15);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 2);
INSERT INTO  tagsPosts (tagID, recipeID) values (15, 24);
INSERT INTO  tagsPosts (tagID, recipeID) values (5, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 22);
INSERT INTO  tagsPosts (tagID, recipeID) values (18, 25);
INSERT INTO  tagsPosts (tagID, recipeID) values (2, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (11, 15);
INSERT INTO  tagsPosts (tagID, recipeID) values (18, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (28, 7);
INSERT INTO  tagsPosts (tagID, recipeID) values (16, 9);
INSERT INTO  tagsPosts (tagID, recipeID) values (10, 28);
INSERT INTO  tagsPosts (tagID, recipeID) values (8, 17);
INSERT INTO  tagsPosts (tagID, recipeID) values (13, 29);
INSERT INTO  tagsPosts (tagID, recipeID) values (13, 10);
INSERT INTO  tagsPosts (tagID, recipeID) values (25, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 26);
INSERT INTO  tagsPosts (tagID, recipeID) values (4, 6);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (30, 26);
INSERT INTO  tagsPosts (tagID, recipeID) values (23, 9);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 25);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 27);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 29);
INSERT INTO  tagsPosts (tagID, recipeID) values (18, 35);
INSERT INTO  tagsPosts (tagID, recipeID) values (23, 27);
INSERT INTO  tagsPosts (tagID, recipeID) values (30, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (21, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (27, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (17, 16);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 19);
INSERT INTO  tagsPosts (tagID, recipeID) values (30, 1);
INSERT INTO  tagsPosts (tagID, recipeID) values (15, 8);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 19);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 1);
INSERT INTO  tagsPosts (tagID, recipeID) values (26, 19);
INSERT INTO  tagsPosts (tagID, recipeID) values (21, 29);
INSERT INTO  tagsPosts (tagID, recipeID) values (30, 16);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 29);
INSERT INTO  tagsPosts (tagID, recipeID) values (15, 9);
INSERT INTO  tagsPosts (tagID, recipeID) values (16, 4);
INSERT INTO  tagsPosts (tagID, recipeID) values (3, 22);
INSERT INTO  tagsPosts (tagID, recipeID) values (26, 28);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 14);
INSERT INTO  tagsPosts (tagID, recipeID) values (17, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (23, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (20, 15);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 2);
INSERT INTO  tagsPosts (tagID, recipeID) values (5, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (5, 3);
INSERT INTO  tagsPosts (tagID, recipeID) values (10, 8);
INSERT INTO  tagsPosts (tagID, recipeID) values (7, 25);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 17);
INSERT INTO  tagsPosts (tagID, recipeID) values (14, 1);
INSERT INTO  tagsPosts (tagID, recipeID) values (20, 10);
INSERT INTO  tagsPosts (tagID, recipeID) values (15, 17);
INSERT INTO  tagsPosts (tagID, recipeID) values (2, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 14);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 10);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 26);
INSERT INTO  tagsPosts (tagID, recipeID) values (22, 27);
INSERT INTO  tagsPosts (tagID, recipeID) values (16, 19);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 28);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 6);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 4);
INSERT INTO  tagsPosts (tagID, recipeID) values (27, 28);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (3, 6);
INSERT INTO  tagsPosts (tagID, recipeID) values (26, 18);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 29);
INSERT INTO  tagsPosts (tagID, recipeID) values (2, 16);
INSERT INTO  tagsPosts (tagID, recipeID) values (17, 18);
INSERT INTO  tagsPosts (tagID, recipeID) values (25, 6);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (23, 6);
INSERT INTO  tagsPosts (tagID, recipeID) values (24, 1);
INSERT INTO  tagsPosts (tagID, recipeID) values (2, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 17);
INSERT INTO  tagsPosts (tagID, recipeID) values (14, 7);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 15);
INSERT INTO  tagsPosts (tagID, recipeID) values (27, 30);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (11, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (28, 27);
INSERT INTO  tagsPosts (tagID, recipeID) values (22, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (4, 8);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 27);
INSERT INTO  tagsPosts (tagID, recipeID) values (9, 20);
INSERT INTO  tagsPosts (tagID, recipeID) values (4, 9);
INSERT INTO  tagsPosts (tagID, recipeID) values (1, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (19, 21);
INSERT INTO  tagsPosts (tagID, recipeID) values (16, 10);
INSERT INTO  tagsPosts (tagID, recipeID) values (18, 10);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 8);
INSERT INTO  tagsPosts (tagID, recipeID) values (6, 23);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 1);
INSERT INTO  tagsPosts (tagID, recipeID) values (29, 15);
INSERT INTO  tagsPosts (tagID, recipeID) values (14, 17);
INSERT INTO  tagsPosts (tagID, recipeID) values (12, 13);
INSERT INTO  tagsPosts (tagID, recipeID) values (24, 5);
INSERT INTO  tagsPosts (tagID, recipeID) values (14, 24);


-- insert 30 sample meal plans
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-02-17 18:21:31', 'Tree nuts', 22);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-10-31 18:21:31', null, 14);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-02-18 14:33:13', 'Peanuts', 24);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-12-06 08:39:02', 'Gluten', 2);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-12-15 20:58:50', null, 24);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-12-11 21:02:26', null, 19);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-12-08 16:27:37', null, 8);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-04-12 04:17:26', 'Wheat', 22);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-09-12 14:20:29', null, 21);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-05-24 13:11:14', 'Wheat', 9);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-05-24 23:17:23', null, 28);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-02-08 21:07:55', 'Gluten', 21);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-03-13 14:26:41', 'Tree nuts', 7);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-06-14 20:22:07', null, 14);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-09-30 21:33:41', 'Wheat', 10);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-03-05 17:00:32', 'Fish', 22);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-10-05 23:35:13', 'Fish', 24);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-07-19 05:17:56', null, 30);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-08-29 08:36:19', null, 21);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-11-05 16:41:05', null, 20);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-08-12 00:02:38', 'Gluten', 14);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-10-10 04:47:13', null, 28);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-01-10 06:18:03', 'Gluten', 9);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-11-28 21:05:38', 'Wheat', 26);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-08-31 13:47:49', 'Soy', 16);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-04-30 03:36:29', 'Sesame', 30);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-09-28 14:30:11', null, 27);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-02-21 18:17:16', null, 19);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2024-04-16 06:15:59', null, 4);
INSERT INTO  MealPlan (addDate, allergens, userID) values ('2025-04-04 10:20:56', null, 15);


-- insert 130 statements into MealPlan_goals
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (17, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (21, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (16, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (24, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (19, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (12, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (16, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (8, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (19, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (6, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (11, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (16, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (23, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (27, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (2, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (13, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (13, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (6, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (11, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (12, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (17, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (11, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (26, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (4, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (2, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (28, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (26, 'increase protein consumption');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (8, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (10, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (18, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (29, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (30, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (19, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (8, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (12, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (9, 'increase protein consumption');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (10, 'increase protein consumption');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (14, 'increase protein consumption');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (19, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (24, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (26, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (2, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (16, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (20, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'increase protein consumption');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (15, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (27, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (21, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (13, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (25, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (15, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (16, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (15, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (11, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (17, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (14, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (28, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (14, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (27, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (21, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (13, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (12, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (15, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (14, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (17, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (11, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (27, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (28, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (13, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (4, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (5, 'drink more water');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (20, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (14, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (18, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (19, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (23, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (9, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (10, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (16, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (17, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (15, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (30, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (29, 'increase protein consumption');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (27, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (28, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (22, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (15, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (10, 'mindful eating');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (3, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (6, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (8, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (28, 'meal prep');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (9, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (11, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (4, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (21, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (26, 'limit processed foods');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (1, 'limit caffeine intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (2, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (20, 'reduce sugar intake');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (25, 'balanced meals');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (25, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (26, 'portion control');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (24, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (7, 'eat more vegetables');
INSERT INTO  MealPlan_goals (mealPlanId, goals) values (12, 'balanced meals');


-- insert 30 sample meal plan infos
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 19);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Gluten', 18);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Tree nuts', 12);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Peanuts', 5);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 22);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 29);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Soy', 27);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 17);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Fish', 26);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 5);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 17);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Soy', 1);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 26);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 2);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 19);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 23);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 21);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 24);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 15);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 8);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Milk', 1);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 7);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 30);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Peanuts', 14);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Milk', 20);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 20);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Peanuts', 14);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 19);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES (NULL, 3);
INSERT INTO MealPlanInfo (allergens, recipeID) VALUES ('Fish', 11);


-- insert 125 meal plan infos goals  -----
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'vegan');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'quick and easy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (7, 'quick and easy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (23, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'carb-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'kid friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'kid friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'carb-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'balanced');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (7, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'heart healthy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (18, 'carb-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'vegan');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (6, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (3, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'balanced');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'carb-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (16, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'high calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'balanced');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'vegan');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (16, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (23, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'anti-inflammatory');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (12, 'balanced');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'carb-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'heart healthy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (3, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (7, 'meal prep friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (20, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (19, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'vegan');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (16, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (29, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'kid friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'high calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (6, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'heart healthy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (2, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'high calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'quick and easy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'high calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (21, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (28, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (12, 'fiber rich');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (14, 'heart healthy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (1, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (19, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (27, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (25, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'heart healthy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (11, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (30, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (24, 'fiber rich');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'fiber rich');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (17, 'kid friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (13, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (4, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (15, 'vegetarian');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'budget friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'heart healthy');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (23, 'high calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (12, 'fat-free');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'high protein');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'low calorie');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'variety');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (10, 'kid friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (17, 'fiber rich');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (22, 'keto');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (26, 'kid friendly');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (18, 'balanced');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (5, 'low sodium');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (8, 'fiber rich');
INSERT INTO  MealPlanInfo_goals (mealPlanInfoId, goals) values (9, 'fat-free');


-- insert 125 sample recipe_meal plan info
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 6);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 8);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 20);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 21);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 4);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 15);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 17);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 22);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 21);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 9);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 7);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 28);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 27);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 14);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 6);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (7, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 15);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (10, 4);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 5);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 16);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 23);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 26);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 11);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 21);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 21);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (9, 10);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 12);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 26);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 28);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 30);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 6);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 15);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 4);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (7, 14);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 14);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 27);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 6);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 29);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 2);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 2);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 9);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 16);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 4);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 29);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 30);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 20);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (6, 26);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 2);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 11);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 16);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 16);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 29);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 9);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 7);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (3, 20);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 26);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 12);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 24);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 5);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 11);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 8);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 16);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (21, 27);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 11);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 27);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 29);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 4);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 18);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (10, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (27, 2);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 12);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 6);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 6);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 12);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (26, 23);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (1, 3);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (15, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 21);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (25, 21);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (3, 8);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (12, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 10);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 12);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (18, 3);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (29, 27);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 27);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (2, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 20);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (8, 7);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 14);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (6, 25);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (24, 24);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (3, 1);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (14, 2);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (16, 18);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 8);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (23, 13);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (26, 20);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 19);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (28, 19);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (20, 7);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (22, 26);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (30, 4);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (13, 26);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (19, 15);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (4, 22);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (26, 2);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (8, 24);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (5, 20);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (8, 17);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (11, 24);
INSERT INTO  Recipe_MealPlanInfo (mealPlanInfoId, recipeID) values (17, 9);






-- insert 75 rows into userInfo
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (1, 1, '2025-03-29 12:05:31', 94);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (2, 3, '2024-12-17 12:05:31', 17);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (3, 1, '2024-04-29 12:05:31', 94);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (4, 1, '2024-06-12 12:05:31', 54);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (5, 0, '2025-02-22 12:05:31', 27);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (6, 8, '2024-06-06 12:05:31', 3);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (7, 3, '2024-05-13 12:05:31', 89);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (8, 6, '2024-12-19 12:05:31', 57);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (9, 4, '2025-04-07 12:05:31', 97);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (10, 6, '2024-10-18 12:05:31', 35);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (11, 9, '2024-12-25 12:05:31', 41);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (12, 6, '2024-09-22 12:05:31', 14);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (13, 7, '2024-09-06 12:05:31', 15);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (14, 1, '2024-09-26 12:05:31', 48);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (15, 6, '2024-07-19 12:05:31', 4);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (16, 0, '2024-04-12 12:05:31', 9);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (17, 6, '2024-06-07 12:05:31', 3);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (18, 4, '2025-01-04 12:05:31', 80);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (19, 9, '2024-04-13 12:05:31', 1);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (20, 5, '2024-05-16 12:05:31', 55);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (21, 0, '2024-04-23 12:05:31', 26);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (22, 1, '2024-08-08 12:05:31', 19);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (23, 1, '2024-06-06 12:05:31', 90);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (24, 9, '2025-01-01 12:05:31', 19);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (25, 4, '2025-02-02 12:05:31', 47);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (26, 2, '2024-12-14 12:05:31', 56);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (27, 8, '2024-10-25 12:05:31', 31);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (28, 3, '2024-06-27 12:05:31', 92);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (29, 9, '2025-02-12 12:05:31', 23);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (30, 9, '2025-01-25 12:05:31', 84);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (31, 3, '2025-03-10 12:05:31', 14);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (32, 2, '2024-04-25 12:05:31', 59);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (33, 2, '2024-06-11 12:05:31', 64);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (34, 0, '2024-07-06 12:05:31', 79);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (35, 0, '2024-05-06 12:05:31', 41);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (36, 0, '2024-05-04 12:05:31', 42);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (37, 5, '2024-12-14 12:05:31', 78);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (38, 4, '2024-06-30 12:05:31', 91);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (39, 5, '2024-09-03 12:05:31', 30);
INSERT INTO UserInfo (userID, mealPlanCount, lastLoggedOn, commentCount) VALUES (40, 0, '2024-12-06 12:05:31', 21);


-- insert 60 statements into UserDemographics
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (39.0, 'Male', 0.61, 0.43, 17);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (26.4, 'Male', 0.74, 0.58, 13);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (48.2, 'Female', 0.29, 0.73, 6);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (23.3, 'Male', 0.21, 0.38, 19);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (32.1, 'Female', 0.67, 0.59, 4);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (44.6, 'Female', 0.39, 0.25, 23);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (36.5, 'Male', 0.53, 0.79, 11);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (20.1, 'Female', 0.19, 0.62, 3);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (27.9, 'Male', 0.82, 0.71, 8);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (38.6, 'Female', 0.31, 0.66, 1);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (49.5, 'Male', 0.25, 0.44, 21);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (29.7, 'Female', 0.73, 0.88, 30);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (31.6, 'Male', 0.62, 0.51, 10);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (22.4, 'Female', 0.15, 0.93, 16);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (40.3, 'Male', 0.45, 0.48, 5);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (33.5, 'Female', 0.37, 0.79, 12);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (24.9, 'Male', 0.88, 0.91, 28);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (37.4, 'Female', 0.49, 0.64, 26);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (42.2, 'Male', 0.22, 0.19, 18);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (35.1, 'Female', 0.66, 0.31, 27);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (47.8, 'Male', 0.36, 0.83, 20);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (25.3, 'Female', 0.55, 0.74, 15);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (30.2, 'Male', 0.69, 0.89, 24);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (43.9, 'Female', 0.48, 0.54, 22);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (21.8, 'Male', 0.12, 0.39, 29);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (46.2, 'Female', 0.27, 0.51, 3);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (37.8, 'Male', 0.64, 0.77, 7);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (23.1, 'Female', 0.10, 0.96, 1);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (41.7, 'Male', 0.58, 0.42, 16);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (29.3, 'Female', 0.43, 0.71, 11);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (35.8, 'Male', 0.70, 0.63, 9);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (27.4, 'Female', 0.35, 0.85, 13);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (50.0, 'Male', 0.60, 0.78, 4);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (22.7, 'Female', 0.18, 0.90, 6);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (36.3, 'Male', 0.49, 0.67, 14);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (39.5, 'Female', 0.51, 0.58, 2);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (26.9, 'Male', 0.76, 0.93, 5);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (30.6, 'Female', 0.59, 0.62, 8);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (44.2, 'Male', 0.41, 0.33, 10);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (31.9, 'Female', 0.38, 0.72, 17);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (28.5, 'Male', 0.63, 0.87, 12);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (33.2, 'Female', 0.30, 0.40, 19);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (42.6, 'Male', 0.55, 0.79, 18);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (25.7, 'Female', 0.67, 0.60, 15);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (38.1, 'Male', 0.50, 0.52, 20);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (34.9, 'Female', 0.44, 0.36, 22);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (40.8, 'Male', 0.46, 0.81, 23);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (32.8, 'Female', 0.72, 0.86, 24);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (27.6, 'Male', 0.39, 0.66, 26);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (46.7, 'Female', 0.26, 0.45, 27);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (22.1, 'Male', 0.14, 0.97, 28);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (29.0, 'Female', 0.52, 0.50, 29);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (35.6, 'Male', 0.71, 0.75, 30);
INSERT INTO UserDemographics (avgAge, avgGender, allergenFrequency, goalFrequency, demUserID) VALUES (31.2, 'Female', 0.25, 0.83, 22);


-- insert 40 investorReport entries without explicitly inserting reportId
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-05-10', 12.5, 3);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-06-14', 9.3, 7);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-07-01', 14.2, 11);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-07-21', 11.8, 15);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-08-05', 13.0, 4);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-08-17', 10.6, 6);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-09-01', 16.7, 12);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-09-12', 8.9, 18);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-09-30', 15.4, 21);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-10-10', 9.0, 25);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-10-22', 13.8, 8);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-11-01', 11.3, 14);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-11-15', 17.5, 10);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-11-28', 10.2, 22);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-12-05', 12.1, 19);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2024-12-17', 14.7, 5);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-01-01', 9.5, 20);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-01-09', 13.9, 13);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-01-18', 15.6, 9);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-01-25', 10.0, 17);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-02-02', 16.2, 23);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-02-13', 14.0, 6);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-02-20', 12.8, 24);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-02-25', 11.9, 27);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-03-03', 13.2, 1);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-03-10', 15.8, 30);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-03-18', 9.1, 29);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-03-23', 13.4, 26);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-03-30', 12.3, 2);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-01', 14.9, 16);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-02', 10.8, 28);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-03', 11.1, 5);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-04', 12.6, 17);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-05', 13.7, 7);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-06', 14.3, 12);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-07', 10.9, 3);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-08', 15.1, 8);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-09', 9.8, 2);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-09', 13.3, 10);
INSERT INTO  InvestorReport (dateGenerated, growthRate, investUserID) values ('2025-04-09', 11.7, 14);


-- contentModeration 40 rows
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-11 08:15:00', 'Flagged', 1, 1);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-06-13 13:45:00', 'Approved', 2, 2);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-12-19 17:30:00', 'Removed', 3, 3);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-01-31 09:10:00', 'Flagged', 4, 4);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-10-16 16:05:00', 'Approved', 5, 5);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-09 10:20:00', 'Removed', 6, 6);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-01-31 14:55:00', 'Flagged', 7, 7);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-03-28 11:35:00', 'Approved', 8, 8);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-04-02 15:00:00', 'Removed', 9, 9);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-08 12:45:00', 'Flagged', 10, 10);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-02-28 08:30:00', 'Approved', 11, 11);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-02-26 20:15:00', 'Removed', 12, 12);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-01-31 21:00:00', 'Flagged', 13, 13);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-08-19 07:45:00', 'Approved', 14, 14);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-06-12 06:30:00', 'Removed', 15, 15);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-07-07 18:15:00', 'Flagged', 16, 16);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-04-13 22:05:00', 'Approved', 17, 17);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-07-22 13:20:00', 'Removed', 18, 18);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-02-17 19:00:00', 'Flagged', 19, 19);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-04-25 11:10:00', 'Approved', 20, 20);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-10-19 14:30:00', 'Removed', 21, 21);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-03 10:05:00', 'Flagged', 22, 22);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-10-17 16:45:00', 'Approved', 23, 23);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-11-26 08:50:00', 'Removed', 24, 24);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-02-27 12:35:00', 'Flagged', 25, 25);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-19 17:00:00', 'Approved', 26, 26);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-11-18 09:40:00', 'Removed', 27, 27);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-03-18 20:05:00', 'Flagged', 28, 28);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-28 19:30:00', 'Approved', 29, 29);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-11-02 07:55:00', 'Removed', 30, 30);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-07-10 13:00:00', 'Flagged', 31, 31);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-07-13 15:20:00', 'Approved', 32, 32);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-08-22 17:35:00', 'Removed', 33, 33);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-01-15 06:50:00', 'Flagged', 34, 34);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-08-06 14:10:00', 'Approved', 35, 35);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-04-20 10:30:00', 'Removed', 36, 36);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-08-04 18:00:00', 'Flagged', 37, 37);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2025-01-23 12:25:00', 'Approved', 38, 38);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-07-23 16:15:00', 'Removed', 39, 39);
INSERT INTO ContentModeration (dateModerated, action, modRecipeID, modUserID) VALUES ('2024-09-06 09:05:00', 'Flagged', 40, 40);


-- insert 40 rows into appUpdate
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-04-25 23:48:07', '2.7.9', 1);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-07-16 05:14:55', '2.7.9', 2);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-15 14:09:25', '2.7.9', 3);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-01-21 02:46:24', '12.2.6', 4);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-21 20:04:39', '1.0.1', 5);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-22 13:24:44', '2.7.9', 6);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-09-21 00:49:38', '1.0.0', 7);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-01-08 05:01:23', '1.0.1', 8);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-09-07 21:12:36', '12.2.6', 9);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-07-29 06:22:11', '1.0.0', 10);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-06-10 02:27:19', '1.0.0', 11);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-02-18 18:13:54', '2.7.9', 12);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-06-27 22:17:21', '2.7.9', 13);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-08-17 20:46:22', '15.1.0', 14);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-03-15 08:16:31', '2.7.9', 15);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-06-30 16:31:18', '15.1.0', 16);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-09-18 04:42:10', '12.2.6', 17);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-12 10:19:56', '2.7.9', 18);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-08-29 09:09:49', '1.0.1', 19);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-09-24 22:18:24', '1.0.0', 20);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-04-16 18:03:17', '1.0.0', 21);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-03-30 00:38:17', '12.2.6', 22);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-09-30 08:16:01', '15.1.0', 23);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-08-22 14:31:08', '1.0.0', 24);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-08-26 02:52:17', '2.7.9', 25);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-02-11 20:49:07', '1.0.0', 26);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-11-20 10:36:33', '1.0.1', 27);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-06-30 04:25:34', '2.7.9', 28);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-07-22 04:35:29', '12.2.6', 29);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-11-15 01:41:33', '12.2.6', 30);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-05-12 06:51:21', '1.0.0', 31);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-13 13:00:17', '2.7.9', 32);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-08-25 20:30:01', '1.0.1', 33);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-11 11:00:25', '2.7.9', 34);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-04-30 15:16:25', '12.2.6', 35);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-03-20 23:00:33', '1.0.0', 36);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-10-29 09:06:01', '1.0.1', 37);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-04-06 14:13:51', '12.2.6', 38);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2024-06-08 04:52:52', '12.2.6', 39);
INSERT INTO  AppUpdate (dateImplemented, version, appUserID) values ('2025-03-25 10:16:14', '1.0.0', 40);


-- insert 40 rows into reportManagement
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-18 07:24:06', 'Reviewed and dismissed', 'completed', 1);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-03-09 21:38:02', 'Reviewed and dismissed', 'completed', 2);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-06-15 07:27:12', 'User issued a warning', 'active', 3);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-27 11:09:49', 'Reviewed and dismissed', 'cancelled', 4);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-03-24 21:17:45', 'User banned', 'pending', 5);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-10-01 16:23:03', 'User banned', 'cancelled', 6);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-06 16:29:42', 'User banned', 'active', 7);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-10-21 03:29:47', 'User banned', 'pending', 8);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-01-23 15:53:40', 'User banned', 'cancelled', 9);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-03-29 14:01:14', 'User banned', 'completed', 10);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-08-17 00:10:38', 'Reviewed and dismissed', 'active', 11);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-09-27 07:20:53', 'Reviewed and dismissed', 'active', 12);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-01-01 21:05:54', 'User banned', 'completed', 13);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-05-10 13:33:14', 'User issued a warning', 'active', 14);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-08-25 01:04:52', 'Reviewed and dismissed', 'active', 15);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-02-18 07:05:05', 'User banned', 'pending', 16);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-01-12 07:46:12', 'User banned', 'active', 17);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-06-22 01:54:58', 'User issued a warning', 'completed', 18);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-07-03 09:07:39', 'User banned', 'pending', 19);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-02-16 22:19:46', 'User issued a warning', 'active', 20);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-07-12 22:38:13', 'User banned', 'pending', 21);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-07-18 15:09:28', 'Reviewed and dismissed', 'active', 22);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-04-03 22:30:07', 'User issued a warning', 'cancelled', 23);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-01-11 15:12:01', 'Reviewed and dismissed', 'pending', 24);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-08-07 07:35:53', 'User issued a warning', 'cancelled', 25);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-12-29 21:00:17', 'Reviewed and dismissed', 'cancelled', 26);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-04-26 20:00:50', 'Reviewed and dismissed', 'cancelled', 27);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-12-29 23:45:05', 'Reviewed and dismissed', 'completed', 28);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-12-03 11:53:11', 'User issued a warning', 'completed', 29);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-01 08:33:37', 'User issued a warning', 'pending', 30);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-03-01 20:27:30', 'Reviewed and dismissed', 'cancelled', 31);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-10-05 09:33:50', 'User issued a warning', 'active', 32);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-03-19 14:48:20', 'Reviewed and dismissed', 'completed', 33);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-30 07:10:46', 'User banned', 'pending', 34);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2025-01-22 03:48:35', 'Reviewed and dismissed', 'pending', 35);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-05-09 13:22:54', 'Reviewed and dismissed', 'active', 36);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-09-20 04:57:48', 'User banned', 'active', 37);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-06-13 16:28:04', 'User issued a warning', 'active', 38);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-30 05:35:53', 'User issued a warning', 'cancelled', 39);
INSERT INTO  ReportManagement (dateReported, action, status, reportUserID) values ('2024-11-24 16:47:37', 'Reviewed and dismissed', 'pending', 40);

SELECT *
FROM Reviews;