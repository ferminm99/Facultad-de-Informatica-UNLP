package e2;

import javax.swing.*;
import java.awt.*;
import java.io.File;
import java.util.Objects;

public class ListEntry {

    private String value;
    private ImageIcon icon;

    public ListEntry(String value, ImageIcon icon) {
        this.value = value;
        this.icon = icon;
    }
    public ListEntry(String value) {
            this.value = value;
            String iconName;

            File f = new File(this.value);
            if (f.exists()){ iconName = this.value;}
            else {iconName = "questionMark";}
            ImageIcon imageIcon = new ImageIcon(iconName);
            Image image = imageIcon.getImage(); // transform it
            Image newimg = image.getScaledInstance(10, 10,  java.awt.Image.SCALE_SMOOTH); // scale it the smooth way
            imageIcon = new ImageIcon(newimg);  // transform it back
            this.icon = imageIcon;
        }

    public String getValue() {
        return value;
    }

    public ImageIcon getIcon() {
        return icon;
    }

    public String toString() {
        return value;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ListEntry listEntry = (ListEntry) o;
        return Objects.equals(value, listEntry.value);
    }

    @Override
    public int hashCode() {
        return Objects.hash(value);
    }
}
