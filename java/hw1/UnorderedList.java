/**
 * 
 */
package assign1;

/**
 * @author ldamon
 *
 */
public interface UnorderedList {

	/**
	 * InsertEnd adds the value at the end of the list. If the queue is full, an exception is thrown.
	 * @param value the value to insert
	 */
	public void insertEnd(int value); 
	
	/**
	 * InsertEnd adds the value at the end of the list. If the queue is full, an exception is thrown.
	 * @param location the place to insert the element.  Locations range from 0 to size-1
	 * @param value the value to insert
	 */
	public void insertAt(int location, int value); 
	
	/**
	 * get the value at the specified location
	 * @param location
	 * @return the value
	 */
	public int get(int location);


	/** 
	 * Find returns the index of the value matching the given value
	 * @param item the item to locate
	 * @return the index of the item or -1 if it doesn't exist
	 */
	public int indexOf(int item);

	
	/**
	 * Remove the specified item.
	 * @param item to remove
	 * @return true if the item is found and removed, false if the item isn't found
	 */
	public boolean remove(int item);


	/**
	 * The size method returns the number of elements found in the list.
	 * @return the size of the list at this time
	 */
	public int size();
	
	/**
	 * The isEmpty method checks if the list is empty. 
	 * @return true if the list is empty (has no elements), false otherwise
	 */
	public boolean isEmpty();
	

	/**
	 * The isFull method checks the list is full.
	 * @return true if the list has no room left, false if more elements can be inserted
	 */
	public boolean isFull();
	
	/**
	 * Empty the list.
	 */
	public void clear();
}
