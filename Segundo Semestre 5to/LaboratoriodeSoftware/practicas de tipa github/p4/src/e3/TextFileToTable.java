package e3;

import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class TextFileToTable {
    private JTable mainTable;
    private JPanel mainPanel;
    private JButton fillTableButton;
    private JTextArea fileField;
    private JLabel inputLabel;
    private JScrollPane scrollPane;
    private JTextArea textArea1;

    // test -> /home/camila/Desktop/t
    public TextFileToTable() {

        String columns[] =  { "1", "2", "3" };
        // JTable mainTable = new JTable();
        DefaultTableModel tableModel;
        // specify number of columns
        tableModel = new DefaultTableModel(0,3);
        tableModel.setColumnIdentifiers(columns);
        mainTable.setModel(tableModel);

        fillTableButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                    String path = fileField.getText();
                    File file = new File(path);
                    String msg;
                    if (file.exists() && file.canRead()) msg = " ¡¡¡¡ File exists !!!!";
                    else msg = "Oops! It seems file doesn't exist or can't be opened....";
                    textArea1.setText(msg);
                    try {
                        BufferedReader br = new BufferedReader(new FileReader(file));
                        Object[] tableLines = br.lines().toArray();
                        for (int i = 0; i < tableLines.length; i++) {
                            String line = tableLines[i].toString().trim();
                            String[] dataRow = line.split(":");
                            // debug
                            for (int j = 0; j < dataRow.length; j++) {
                                System.out.println(dataRow[j]);
                            }
                            if (dataRow.length > 3)  textArea1.setText("Incorrect format! Too much data for one row ... the extra data wont be visible");
                            tableModel.insertRow(i, dataRow);
                        }
                    } catch (Exception e1) {
                        e1.printStackTrace();
                    }
                }
        });
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("TextFileToTable");
        frame.setContentPane(new TextFileToTable().mainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }

}
