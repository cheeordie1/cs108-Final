package assignment;

import java.util.*;

public class Matching extends Answer {

	ArrayList<String> leftOptions, rightOptions;
	Map<String, String> matches;
	
	public Matching(String options) {
		leftOptions = new ArrayList<String>();
		rightOptions = new ArrayList<String>();
		matches = new HashMap<String, String>();
		parseOptions(options);
	}

	public Matching() {
		leftOptions = new ArrayList<String>();
		rightOptions = new ArrayList<String>();
		matches = new HashMap<String, String>();
	}
	
	public void addAnswer(String answer) {
		String[] pair = answer.split("=");
		matches.put(pair[0], pair[1]);
	}
	
	public void addLeftOption(String option) {
		leftOptions.add(option);
	}
	
	public void addRightOption(String option) {
		rightOptions.add(option);
	}
	
	public void deleteLeftOption(String option) {
		leftOptions.remove(option);
		if (matches.containsKey(option)) {
			matches.remove(option);
		}
	}
	
	public void deleteRightOption(String option) {
		rightOptions.remove(option);
		for (String key : matches.keySet()) {
			if (matches.get(key) == option) {
				matches.remove(key);
			}
		}
	}
	
	public void deleteAnswer(String answer) {
		matches.remove(answer);
	}
	
	@Override
	public boolean isValid() {
		if (leftOptions.isEmpty() || rightOptions.isEmpty() || matches.isEmpty()) {
			return false;
		}
		
		for (String key : matches.keySet()) {
			if (!leftOptions.contains(key)) {
				return false;
			}
			if (!rightOptions.contains(matches.get(key))) {
				return false;
			}
		}
		
		return true;
	}
	
	@Override
	public String toString() {
		StringBuilder result = new StringBuilder();
		for (int i = 0; i < leftOptions.size(); i++) {
			if (i != leftOptions.size() - 1) {
				result.append(leftOptions.get(i) + SEPERATOR);
			} else {
				result.append(leftOptions.get(i));
			}
		}
		
		result.append(DELIM);
		
		for (int i = 0; i < rightOptions.size(); i++) {
			if (i != rightOptions.size() - 1) {
				result.append(rightOptions.get(i) + SEPERATOR);
			} else {
				result.append(rightOptions.get(i));
			}
		}
		
		result.append(DELIM);
		
		int matchNum = 0;
		for (String key : matches.keySet()) {
			if (matchNum != matches.size() - 1) {
				result.append(key +"="+ matches.get(key) +SEPERATOR);
			} else {
				result.append(key +"="+ matches.get(key));
			}
			matchNum++;
		}
		
		return result.toString();
	}
	
	private void parseOptions(String options) {
		// example of options 
		// duck, goose, ribbon<>ball, red, fly<>duck=ball, goose=red, ribbon=fly
		String[] parsedAnswer = options.split(DELIM);
		
		String leftOptionsStr = parsedAnswer[0];
		String rightOptionsStr = parsedAnswer[1];
		String matchesStr = parsedAnswer[2];
		
		String[] leftOptionsParsed = leftOptionsStr.split(SEPERATOR);
		for (String option : leftOptionsParsed) {
			leftOptions.add(option);
		}
		
		String[] rightOptionsParsed = rightOptionsStr.split(SEPERATOR);
		for (String option : rightOptionsParsed) {
			rightOptions.add(option);
		}
		
		String[] matchesParsed = matchesStr.split(SEPERATOR);
		for (String match : matchesParsed) {
			String[] pair = match.split("=");
			matches.put(pair[0], pair[1]);
		}
	}

	public boolean checkAnswer (String userInput) {
		//user input has to have "<>"
		//example of user input: "milk<>sausage"	
		String[] splitUserInput = userInput.split("=");
		if (matches.get(splitUserInput[0]) != splitUserInput[1]) {
			return false;
		}
		return true;
	}
}
