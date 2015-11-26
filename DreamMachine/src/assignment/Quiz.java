package assignment;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Date;
import java.sql.*;


public class Quiz {
	//IDs that do not change
	public int q_id;
	public int u_id; 
	public Date date;
	public ArrayList<Question> questions;
	
	public String name;
	
	//Quiz Options with Default Values Set
	public boolean singlePage = true;
	public boolean randQuestion = false;
	public boolean immediateCorrect = false;
	public boolean practiceModeOption = false;

	/*
	 * Constructor for making a quiz on website
	 */
	public Quiz () {

	}
	
	/*
	 * Constructor for uploading quiz from database 
	 */
	public Quiz (ResultSet quizData) {
		try {
			this.q_id = quizData.getInt("pid"); 
			this.name = quizData.getString("name");
			this.u_id = quizData.getInt("uid");
			this.date = quizData.getDate("date");
			this.singlePage = quizData.getBoolean("singlePage");
			this.randQuestion = quizData.getBoolean("randQuestion");
			this.practiceModeOption = quizData.getBoolean("practiceModeOpt");
		} catch (Exception ex) {
			//huh?
		}
		populateQuestions(); 
	}
	
	
	/*
	 * Creates a query into the Questions table and 
	 * searches for questions with the same id as the 
	 * quiz. Creates new instances of each question and
	 * adds them to the questions arrayList.  
	 */
	private void populateQuestions() {
		//Returns the set of question entries that are associated with the qid.
		ResultSet questionData = DBConnection.query("SELECT * FROM questions WHERE pid = " + q_id + ";");
		
		/* iterates through question entries, creates an instance of a question,
		 * and adds it to the questions list. */
		while (questionData.next()) {
			//make sure next() doesnt skip first one
			Question question = new Question(questionData);
			questions.add(question);
		}
	}


	/*
	 * Insert the quiz into the quizzes table and assign the 
	 * q_id instance variable to the unique id generated by 
	 * adding the quiz to the table.
	 */
	public boolean save() {
		String entry = "INSERT INTO quizzes (uid,date,singlePage,randQuestion,practiceMode," +
				"immediateCorrect) VALUES(" + getU_id() + "," + getDate() + "," + isSinglePage()
				+ "," + isRandQuestion() + "," + isPracticeMode() +","+ isImmediateCorrect() + ");";
		this.q_id = DBConnection.insertUpdate(entry);
		return true; 
	}

	/*
	 * Saves the question to associate it with the given quiz id
	 * and adds the question to the question list.
	 */
	public void addQuestion (Question question) {
		question.save();
		questions.add(question);
	}
	
	/*
	 * Adds the users score to the Score table 
	 */
	public void enterScore (int score, int time) {
		//Set into scores database
	}
	
	/*
	 * Queries Score table using q_id and returns
	 * the highest score
	 */
	public int HighScore() { 
		/* selects all scores associated with the quiz, sorted from highest score
		 * to lowest score.
		 */
		String queryStr = "SELECT * FROM scores WHERE qid=" + q_id +
				" ORDER BY points DESC;";
		ResultSet scores = DBConnection.query(queryStr);
		
		/* need to advance the result set cursor to the first row. then retrieve the
		 * contents of the points column. 
		 */
		scores.next();
		return scores.getInt("points");
	}

	/*
	 * Returns the result set returned by querying the scores table for scores
	 * associated with the quiz, and ordered in descending order by points
	 */
	public ResultSet getLeaderboard() {
		String queryStr = "SELECT * FROM scores WHERE qid=" +q_id+
				" ORDER BY points DESC;";
		return DBConnection.query(queryStr);
	}
	
	/*
	 * Queries Score table using q_id and returns
	 * the length of the results set. 
	 */
	public int timesPlayed() {
		String queryStr = "SELECT * FROM scores WHERE qid=" +q_id+ ";";
		ResultSet scores_per_quiz = DBConnection.query(queryStr);
		scores_per_quiz.last();
		return scores_per_quiz.getRow();
	}
	
	public boolean isRandQuestion() {
		return randQuestion;
	}


	public void setRandQuestion(boolean randQuestion) {
		this.randQuestion = randQuestion;

		if (randQuestion) {
			Collections.shuffle(questions);
		}
		
	}

	public boolean isImmediateCorrect() {
		return immediateCorrect;
	}


	public void setImmediateCorrect(boolean immediateCorrect) {
		this.immediateCorrect = immediateCorrect;
	}

	public boolean isPracticeMode() {
		return practiceModeOption;
	}


	public void setPracticeMode(boolean practiceMode) {
		this.practiceModeOption = practiceMode;
	}
	
	public boolean isSinglePage() {
		return singlePage;
	}


	public void setSinglePage(boolean singlePage) {
		this.singlePage = singlePage;
	}

	public int getQ_id() {
		return q_id;
	}

	public void setQ_id(int q_id) {
		this.q_id = q_id;
	}

	public int getU_id() {
		return u_id;
	}

	public Date getDate() {
		return date;
	}

}
