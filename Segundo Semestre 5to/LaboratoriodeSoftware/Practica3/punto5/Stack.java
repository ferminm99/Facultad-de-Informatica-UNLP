package punto5;

import java.util.ArrayList;
import java.util.Iterator;

public class Stack<E> implements Iterable<E>{

	private ArrayList<E> items = new ArrayList<E>();
	private int ultimo = 0;
	
	public Stack() {
		
	}
	
	public void push(E item) {
		items.add(item);
		ultimo++;
		//System.out.println("ultimo = "+ultimo);
	}
	
	public E pop() {
		//System.out.println("| ultimo = "+ultimo);
		//System.out.println("| items = "+items);
		return items.remove(--ultimo);
	}
	
	public boolean isEmpty() {
		return items.isEmpty();
	}
	
	public int size() {
		return items.size();
	}
	
	public String toString() {
		return items.toString();
	}
	
	public Iterator<E> iterator() {
		return new Iterator<E>() {
			private int i = 0;

			@Override
			public boolean hasNext() {
				return i < items.size() ;
			}

			@Override
			public E next() {
				E item = items.get(i++);
				return item;
			}
		};
	}
}
