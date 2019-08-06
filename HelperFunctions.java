package com.cs336.pkg;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class HelperFunctions {
	
 	public ArrayList<ArrayList<String>> showQuery(ResultSet result, ArrayList<String> columns){
 		ArrayList<ArrayList<String>> output = new ArrayList<ArrayList<String>>();
 		try {
 			ArrayList<String> row = new ArrayList<String>();
 			// while there is another tuple
			while (result.next()) {
				// add each given column data to the row
				for (int i = 0; i < columns.size(); i++) {
					row.add("" + result.getObject(columns.get(i)));
				}
				output.add(row);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return output;
 		
 	}
}
