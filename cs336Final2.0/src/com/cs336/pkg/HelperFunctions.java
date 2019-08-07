package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class HelperFunctions {
	
 	public ArrayList<ArrayList<String>> getQuery(ResultSet result, ArrayList<String> columns){
 		ArrayList<ArrayList<String>> output = new ArrayList<ArrayList<String>>();
 		try {
 			
 			// while there is another tuple
 			int count = 0;
 			while (result.next()) {
 				count++;
 			}
 			int numTuples = count;
 			
 			// Moves result set iterator to front of result set
 			result.beforeFirst();
 			
			for (int i = 0; i < numTuples; i++) {
				// add each given column data to the row
				if (result.next()) {
					ArrayList<String> row = new ArrayList<String>();
					for (int j = 0; j < columns.size(); j++) {
						row.add("" + result.getObject(columns.get(j)));
					}
					output.add(row);
				}		
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return output;
 		
 	}
 	
 	public String printQuery(ArrayList<ArrayList<String>> tuples, ArrayList<String> columns) {
 		String result;
 		StringBuilder sb = new StringBuilder();
 		
 		sb.append("<table border=\"1\"><thead><tr>");
 		
 		for (int i = 0; i < columns.size() ; i++){
			sb.append("<th>" + columns.get(i) + "</th>");
		}
 		
 		sb.append("</tr></thead><tbody>");
 		
 		for (int i=0; i < tuples.size(); i++){
			sb.append("<tr>");
			for (int j = 0; j < tuples.get(i).size(); j++){
				if (tuples.get(i).get(j) != null){
					String data = (String) tuples.get(i).get(j);
					sb.append("<td>" + data + "</td>");
				}	
			}
			sb.append("</tr>");
		}
		sb.append("</tbody></table>");
 		
		result = sb.toString();
 		return result;
 	}
 	
}