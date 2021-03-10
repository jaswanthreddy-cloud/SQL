

CREATE TABLE Role( 
	roleID   VARCHAR(20) CONSTRAINT valid_roleID CHECK (roleID like 'role_%'), 
	AdminID  VARCHAR(20), 
	studentID VARCHAR(20), 
	FacultyID VARCHAR(20), 
	PRIMARY KEY(roleID) 
);
insert into role values('role_1234','admin',NULL,NULL);
insert into role values('role_4213',NULL,'student',NULL);
insert into role values('role_3214',NULL,NULL,'faculty');



CREATE TABLE Users(
		roleID	    VARCHAR(20),			
		userID	    VARCHAR(20) CONSTRAINT valid_userID CHECK (userID like 'user_%'),
		firstName   VARCHAR(20),
		lastName    VARCHAR(20), 
		address     VARCHAR(50),
		email 	    VARCHAR(20),
		phoneNumber VARCHAR(12),
		PRIMARY KEY(userID),
		FOREIGN KEY(roleID) REFERENCES role(roleID)
);

insert into Users values ('role_1234','user_13579','Sherin','Lude','singapore','sm1298@txstate.edu','3618803220');
insert into Users values ('role_3214','user_24680','Jaswanth','Reddy','India','j_m1635@txstate.edu','5126182700');
insert into Users values ('role_3214','user_35791','Kim','Kadarshian','United States','km1228@txstate.edu','6134482700');
insert into Users values ('role_4213','user_46810','Kanye','West','South Africa','kw2008@txstate.edu','5145227700');
insert into Users values ('role_4213','user_57913','Abu','Omar','Saudi Arabia','ao7828@txstate.edu','2618182700');


CREATE TABLE survey(
		roleID	        VARCHAR(20),
		surveyID 	VARCHAR(20) CONSTRAINT valid_surveyID CHECK (surveyID like 'survey_%'),
		surveyName 	VARCHAR(50),
		surveyType 	VARCHAR(100),
		startDate 	date, 
		endDate 	date, 
		PRIMARY KEY(surveyID),
		FOREIGN KEY(roleID) REFERENCES role(roleID)
);
insert into survey values ('role_1234','survey_1','CS Grad Survey','Grad related Survey',to_date('09-29-2020','MM-DD-YYYY'),to_date('10-29-2020','MM-DD-YYYY'));
insert into survey values ('role_3214','survey_2','library Survey','General college Survey',to_date('09-29-2020','MM-DD-YYYY'),to_date('10-29-2020','MM-DD-YYYY'));
insert into survey values ('role_1234','survey_3','UnderGrad Survey','UnderGrad related Survey',to_date('09-29-2020','MM-DD-YYYY'),to_date('10-29-2020','MM-DD-YYYY'));
insert into survey values ('role_1234','survey_4','MATH Grad Survey','Deparment related Survey',to_date('09-29-2020','MM-DD-YYYY'),to_date('10-29-2020','MM-DD-YYYY'));
insert into survey values ('role_4213','survey_5','GYM Survey','Recreational related Survey',to_date('09-29-2020','MM-DD-YYYY'),to_date('10-29-2020','MM-DD-YYYY'));


CREATE TABLE questions(
		questionID 	VARCHAR(20) CONSTRAINT valid_questionID CHECK (questionId like 'Q_%'),
		question_type 	VARCHAR(20)  CONSTRAINT valid_QuestionTypes CHECK (question_type in ('Likert_Choice','Text_Choice','Bool_Choice')),
		questionBody 	VARCHAR(100), 
PRIMARY KEY(questionID)
);
insert into questions values('Q1','Text_Choice','How many Seminars should be attended by computer science Students?');
insert into questions values('Q2','Bool_Choice','A student have to complete 18 credits in order to attain a computer science Masters degree');
insert into questions values('Q3','Likert_Choice','How many core subjects should be completed by a student in computer science');
insert into questions values('Q4','Bool_Choice','Library does not contain books');
insert into questions values('Q5','Likert_Choice','how many libraries are there in Texas State University');
insert into questions values('Q6','Text_Choice','Where is the Library located?');
insert into questions values('Q7','Text_Choice','What is the exam to attain Admission in Txst university?');
insert into questions values('Q8','Bool_Choice','There are 4 different types of years in undergrad');
insert into questions values('Q9','Likert_Choice','what is full form of UAC?');
insert into questions values('Q10','Text_Choice','Full form of math?');
insert into questions values('Q11','Bool_Choice','Mathematics department has only one professor?');
insert into questions values('Q12','Likert_Choice','Mathematics contain');
insert into questions values('Q13','Likert_Choice','Full form of GYM');
insert into questions values('Q14','Bool_Choice','GYM contain treadmill');
insert into questions values('Q15','Text_Choice','Gym comes under which department?');


CREATE TABLE Likert_Choice(
		questionID 	VARCHAR(20),
		likertAnswer 	CHAR(4),
		likertword 	VARCHAR(50),
 FOREIGN KEY(questionID) REFERENCES questions(questionID) ON DELETE CASCADE
);


INSERT INTO Likert_Choice values('Q5','A','six');
INSERT INTO Likert_Choice values('Q5','B','three');
INSERT INTO Likert_Choice values('Q5','C','four');
INSERT INTO Likert_Choice values('Q5','D','one');
INSERT INTO Likert_Choice values('Q3','A','four');
INSERT INTO Likert_Choice values('Q3','B','three');
INSERT INTO Likert_Choice values('Q3','C','fifty');
INSERT INTO Likert_Choice values('Q3','D','twenty');
INSERT INTO Likert_Choice values('Q9','A','Undergraduate Academic Centre');
INSERT INTO Likert_Choice values('Q9','B','graduate Academic Centre');
INSERT INTO Likert_Choice values('Q9','C','Academic Centre');
INSERT INTO Likert_Choice values('Q9','D','Centre');
INSERT INTO Likert_Choice values('Q12','A','formulas');
INSERT INTO Likert_Choice values('Q12','B','coding');
INSERT INTO Likert_Choice values('Q12','C','cash');
INSERT INTO Likert_Choice values('Q12','D','food');
INSERT INTO Likert_Choice values('Q13','A','gymnasium');
INSERT INTO Likert_Choice values('Q13','B','gymnastics');
INSERT INTO Likert_Choice values('Q13','C','gimmy');
INSERT INTO Likert_Choice values('Q13','D','great yo machines');


CREATE TABLE Text_Choice(
		questionID 	VARCHAR(20),
		Text 		VARCHAR(50), 
		FOREIGN KEY(questionID) REFERENCES questions(questionID) ON DELETE CASCADE
);
insert into Text_Choice values('Q1','four');
insert into Text_Choice values('Q6','center');
insert into Text_Choice values('Q7','SAT');
insert into Text_Choice values('Q10','Mathematics');
insert into Text_Choice values('Q15','Recreation');


CREATE TABLE Bool_Choice(
		questionID 	VARCHAR(20),
		boolValue 	VARCHAR(50) CHECK (boolValue in ( 'TRUE','FALSE' )),
FOREIGN KEY(questionID) REFERENCES questions(questionID) ON DELETE CASCADE
);
insert into Bool_Choice values('Q2','TRUE');
insert into Bool_Choice values('Q4','FALSE');
insert into Bool_Choice values('Q8','TRUE');
insert into Bool_Choice values('Q11','FALSE');
insert into Bool_Choice values('Q14','TRUE');

CREATE TABLE Submission(
		questionID 	VARCHAR(20), 
		userID 		VARCHAR(20), 
		surveyID 	VARCHAR(20), 
		answer	 	VARCHAR(50), 
		FOREIGN KEY(questionID) REFERENCES questions(questionID),
		FOREIGN KEY(surveyID) REFERENCES survey(surveyID),
		FOREIGN KEY(userID) REFERENCES users(userID)
);
insert into Submission values('Q1','user_24680','survey_1','four');
insert into Submission values('Q1','user_35791','survey_1','three');
insert into Submission values('Q1','user_13579','survey_1','six');
insert into Submission values('Q1','user_46810','survey_1','five');
insert into Submission values('Q1','user_57913','survey_1','four');
insert into Submission values('Q2','user_35791','survey_1','TRUE');
insert into Submission values('Q2','user_46810','survey_1','FALSE');
insert into Submission values('Q2','user_24680','survey_1','TRUE');
insert into Submission values('Q2','user_13579','survey_1','FALSE');
insert into Submission values('Q2','user_35791','survey_1','TRUE');
insert into Submission values('Q2','user_35791','survey_1','TRUE');
insert into Submission values('Q3','user_46810','survey_1','D');
insert into Submission values('Q4','user_13579','survey_2','TRUE');
insert into Submission values('Q4','user_24680','survey_2','TRUE');
insert into Submission values('Q4','user_57913','survey_2','TRUE');
insert into Submission values('Q5','user_24680','survey_2','C');
insert into Submission values('Q6','user_13579','survey_2','center');
insert into Submission values('Q7','user_57913','survey_3','SAT');
insert into Submission values('Q8','user_46810','survey_3','TRUE');
insert into Submission values('Q9','user_57913','survey_3','A');
insert into Submission values('Q9','user_46810','survey_3','B');
insert into Submission values('Q9','user_13579','survey_3','C');
insert into Submission values('Q9','user_24680','survey_3','D');
insert into Submission values('Q9','user_35791','survey_3','A');
insert into Submission values('Q10','user_13579','survey_4','Mathematics');
insert into Submission values('Q11','user_24680','survey_4','TRUE');
insert into Submission values('Q12','user_35791','survey_4','A');
insert into Submission values('Q13','user_46810','survey_5','B');
insert into Submission values('Q14','user_57913','survey_5','FALSE');
insert into Submission values('Q15','user_35791','survey_5','Recreation');


SELECT count(*) from Submission WHERE surveyID ='survey_1' AND answer='TRUE' ;
