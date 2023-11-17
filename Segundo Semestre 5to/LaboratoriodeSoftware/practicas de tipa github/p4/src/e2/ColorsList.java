// para ver las fotos de los colores poner una imagen con el mismo nombre del color a agregar en el root del projecto :)
package e2;

import javax.swing.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Iterator;

public class ColorsList {
    private JList colorsList;
    private DefaultListModel listModel;
    private JPanel mainPanel;
    private JButton addButton;
    private JButton deleteButton;
    private JTextField colorInput;
    private ArrayList<String> baseColors;

    public ColorsList() {
        initializeImgsDictionary();
        //  initializeList();
        initializeListWithImages();
        initializeButtons();

    }

    private void initializeImgsDictionary() {
        baseColors = new ArrayList<String>();
        baseColors.add("rojo");
        baseColors.add("verde");
        baseColors.add("azul");
        baseColors.add("violeta");
        baseColors.add("violeta");
        baseColors.add("amarillo");
        baseColors.add("questionMark");
    }

    private void initializeButtons() {
        addButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // listModel.addElement(colorInput.getText());
                listModel.addElement(new ListEntry(colorInput.getText()));
                resetInput();
            }
        });
        deleteButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // listModel.removeElement(colorInput.getText());
                listModel.removeElement(new ListEntry(colorInput.getText()));
            }
        });
    }

    private void initializeList() {
        listModel = new DefaultListModel();
        listModel.addElement("Rojo");
        listModel.addElement("Verde");
        listModel.addElement("Azul");
        listModel.addElement("Violeta");
        listModel.addElement("Amarillo");
        listModel.addElement("Rosa");
        colorsList.setModel(listModel);
    }

    private void initializeListWithImages() {
        listModel = new DefaultListModel();
        fillListModel();
        colorsList.setModel(listModel);
        colorsList.setCellRenderer(new ListEntryCellRenderer());
    }

    private void fillListModel() {
        Iterator i = baseColors.iterator();
        while (i.hasNext()) {
            String s = i.next().toString();
            if ( !s.equals("questionMark")) listModel.addElement(new ListEntry(s));
        }
    }

    private void resetInput(){
        colorInput.setText("");
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("ColorsList");
        frame.setContentPane(new ColorsList().mainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }
}
