
import java.util.AbstractSet;
import java.util.ArrayList;
import java.util.Iterator;

public class StringConverterSet extends AbstractSet{
    private ArrayList data;

    public StringConverterSet() {
        this.data = new ArrayList();
    }

    @Override
    public int size() {
        return data.size();
    }

    @Override
    public boolean add(Object o) {
        return data.add(o);
    }

    @Override
    public boolean remove(Object o) {
        return data.remove(o);
    }

    @Override
    public Iterator iterator() {
        return new IteratorStringAdapter();
    }

    private class IteratorStringAdapter implements Iterator{
        private int index;
        private String str;

        public IteratorStringAdapter(){
            index = 0;
        }

        @Override
        public boolean hasNext() {
            return index < data.size();
        }

        @Override
        public Object next() {
            str = data.get(index).toString();
            index++;
            return str;
        }
    }
}
