/**
 * Assignment 1 for CIS-3050 "Algorithms and Data Structures", with Leslie Damon
 */
package hw1;

// @TODO rework docstrings for entire file

/**
 * @author Jeremy Audet <ichimonji10@gmail.com>
 */
public interface UnorderedList<T> {

    /**
     * Adds <code>value</code> to end of list. Throws exception if queue is
     * full.
     *
     * @param value the value to insert
     */
    public void insertEnd(T value); 

    /**
     * Adds <code>value</code> to list at <code>location</code>. Throws
     * exception if queue is full.
     *
     * @param location the place to insert the element. Locations range from 0 to size-1
     * @param value the value to insert
     */
    public void insertAt(int location, T value); 

    /**
     * Returns value at specified <code>location</code>. Throws exeption if
     * <code>location</code> is out of bounds.
     *
     * @param location Locations range from 0 to size - 1.
     * @return the value
     */
    public T get(int location);

    /** 
     * Find returns the index of the value matching the given value
     *
     * @param item the item to locate
     * @return the index of the item or -1 if it doesn't exist
     */
    public int indexOf(T item);

    /**
     * Remove the specified item.
     *
     * @param item to remove
     * @return true if the item is found and removed, false if the item isn't found
     */
    public boolean remove(T item);

    /**
     * The size method returns the number of elements found in the list.
     *
     * @return the size of the list at this time
     */
    public int size();

    /**
     * The isEmpty method checks if the list is empty. 
     *
     * @return true if the list is empty (has no elements), false otherwise
     */
    public boolean isEmpty();

    /**
     * The isFull method checks the list is full.
     *
     * @return true if the list has no room left, false if more elements can be inserted
     */
    public boolean isFull();

    /**
     * Empty the list.
     */
    public void clear();
}
