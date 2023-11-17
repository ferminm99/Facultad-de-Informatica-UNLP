package e1;

import java.util.ArrayList;
import java.util.Iterator;

public class StackAnnonymous {
        private java.util.ArrayList items;
        private StackIterator stackIterator;

        private interface StackIterator{
            public Iterator iterator(ArrayList a);
        }

        public StackAnnonymous() {
            items = new ArrayList();
            stackIterator = new StackIterator(){
                @Override
                public Iterator iterator(ArrayList a){
                    return a.iterator();
                }
            };
        }

        public void push(Object item){
            items.add(item);
        }

        public Object pop(){
            if(size()==0)
                throw new IllegalStateException("Stack is empty");
            return items.remove(size() - 1);
        }

        public boolean isEmpty(){
            return size() == 0;
        }

        public void finalize(){

        }

        public int size(){
            return items.size();
        }

        public Iterator iterator(){
            return stackIterator.iterator(items);
        }

}
