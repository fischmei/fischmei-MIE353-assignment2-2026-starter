package org.example;

import static java.lang.System.out;

import java.sql.SQLException;

// Import all defined queries
import org.example.queries.*;
// Import schema classes
import org.example.schema.CMS;
import org.example.schema.CMS.*;



public class Main {
    public static void main(String[] args) {

      try {
        // Load in all the data from CSV files in to in-memory DuckDB
        loadCMSData();

        // Example: fetch a student by ID and print their email
        Student s = Student.fetch(9002);
        out.println(s.getEmail());
        // Example: fetch the same student using a parameterized SQL query
        Student s2 = FindStudent.fetchOne(9002);
        out.println(s2.getEmail());

        //Example: saving a table to CSV
        CMS.addSqlChange(ctx -> {
          SaveStudents.execute(ctx);
        });
        CMS.commit();
        
        // EXTRA MAIN FUNCTION CALLS CAN GO BELOW:
        
        // Part 3: Get graduate courses and save to CSV
        availGradCourses();

        // Part 4: Writing Queries
        query1();
        query2();
        query3();
        query4();
        query5();
        query6();
        query7();
        query8();

        
      }
      catch (Exception e) {
        e.printStackTrace();
      }


  }

  public static void loadCMSData() throws SQLException {
    loadStudentData();
    loadProfessorData();
    loadCourseData();

    // Part2 fix add loading method
    // Take loading order into account
    loadTeachesData();

    loadTranscriptData();
  }

  public static void loadStudentData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadStudents.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadProfessorData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadProfessors.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadCourseData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadCourses.execute(ctx);
    });
    CMS.commit();
  }

  public static void loadTranscriptData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadTranscript.execute(ctx);
    });
    CMS.commit();
  }

  // Part2 fix add loading method
  public static void loadTeachesData() throws SQLException {
    CMS.addSqlChange(ctx -> {
      LoadTeaches.execute(ctx);
    });
    CMS.commit();
  }

  // Part 3: Find and output courses available to graduate students
  public static Iterable<Course> availGradCourses() throws SQLException {
    CMS.addSqlChange(ctx -> {
      OutputGradCourses.execute(ctx);
    });
    CMS.commit();

    return FindGradCourses.fetch();
  }

  // Part 4: Call queries

  public static void query1() throws SQLException {
    CMS.addSqlChange(ctx -> {
       Query1.execute(ctx);
    });
    CMS.commit();
  }

  public static void query2() throws SQLException {
    CMS.addSqlChange(ctx -> {
       Query2.execute(ctx);
    });
    CMS.commit();
  }

  public static void query3() throws SQLException {
    CMS.addSqlChange(ctx -> {
      Query3.execute(ctx);
    });
    CMS.commit();
  }

  public static void query4() throws SQLException {
    CMS.addSqlChange(ctx -> {
      Query4.execute(ctx);
    });
    CMS.commit();
  }

  public static void query5() throws SQLException {
    CMS.addSqlChange(ctx -> {
      Query5.execute(ctx);
    });
    CMS.commit();
  }

  public static void query6() throws SQLException {
    CMS.addSqlChange(ctx -> {
      Query6.execute(ctx);
    });
    CMS.commit();
  }

  public static void query7() throws SQLException {
    CMS.addSqlChange(ctx -> {
      Query7.execute(ctx);
    });
    CMS.commit();
  }

  public static void query8() throws SQLException {
    CMS.addSqlChange(ctx -> {
      Query8.execute(ctx);
    });
    CMS.commit();
  }

}