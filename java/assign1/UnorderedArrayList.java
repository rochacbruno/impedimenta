/**
 * Assignment 1 for CIS-3050 "Algorithms and Data Structures", with Leslie Damon
 */
package assign1;

/**
 * Implements UnorderedList using a Java Array.
 * @author Jeremy Audet <ichimonji10@gmail.com>
 */
public class UnorderedArrayList<T> implements UnorderedList<T> {
    /**
     * _list An array containing elements of type <code>T</code>.
     * _size Tells the number of elements currently in <code>_list</code>.
     */
    public final int DEFAULT_ARRAY_LEN = 25;
    private Object[] _list;
    private int _size;

    /**
     * Constructor. Creates a list of length <code>DEFAULT_ARRAY_LEN</code>.
     */
    public UnorderedArrayList() {
        _list = new Object[DEFAULT_ARRAY_LEN];
    }

    /**
     * Constructor. Creates a list of length <code>capacity</code>.
     *
     * @param capacity the maximum size of the list
     */
    public UnorderedArrayList(int capacity) {
        _list = new Object[capacity];
    }

    /**
     * Adds <code>value</code> at end of list. If list is full, throws
     * <code>ListFullException</code>.
     *
     * @param value the value to insert
     */
    public void insertEnd(T value) {
        if(this.isFull()) {
            throw new ListFullException();
        } else {
            _list[_size] = value;
            _size++;
        }
    }

    /**
     * Inserts <code>value</code> into list at <code>location</code>. If list is
     * full, throws <code>ListFullException</code>.
     *
     * @param location Where to insert <code>value</code>. Valid locations are
     * from 0 to size - 1.
     * @param value The value which is inserted.
     */
    public void insertAt(int location, T value) {
        if(this.isFull()) {
            throw new ListFullException();
        }

        for(int i = size(); i > location; i--)
            _list[i] = _list[i - 1];
        _list[location] = value;
        _size++;
    }

    /**
     * Get a copy of the value at location <code>location</code>.
     *
     * @param location The index of the value to return. Valid locations are
     * from 0 to size - 1.
     * @return the value
     */
    public T get(int location) {
        if (location < 0 || location >= _size)
            throw new IndexOutOfBoundsException();
        else
            return (T)_list[location];
    }

    /** 
     * Returns the index of the first item matching <code>value</code>.
     *
     * @param item the item to locate
     * @return the index of the item or -1 if it doesn't exist
     */
    public int indexOf(T item) {
        for (int i = 0; i < size(); i++) {
            if (_list[i] == item)
                return i;
        }
        return -1;  // if here, we didn't find it.
    }

    /**
     * Removes the specified item.
     *
     * @param item to remove
     * @return true if the item is found and removed, false if the item isn't found
     */
    public boolean remove(T item) {
        int index = indexOf(item);
        if (index == -1)
            return false;

        // Item found. Must move all following elements in array to the left.
        for (int i = index; i < size()-1; i++) {
            _list[i] = _list[i+1];
        }
        _size--;
        return true;
    }

    /**
     * Returns the number of elements in the list.
     *
     * @return the size of the list at this time
     */
    public int size() {
        return _size;
    }

    /**
     * Checks if list is empty.
     *
     * @return true if the list is empty (has no elements), false otherwise
     */
    public boolean isEmpty() {
        if (_size==0)
            return true;
        else
            return false;
    }

    /**
     * Checks if list is full.
     *
     * @return true if the list has no room left, false if more elements can be inserted
     */
    public boolean isFull() {
        if (_size == _list.length)
            return true;    
        else 
            return false;
    }

    /**
     * Empties the list.
     */
    public void clear() {
        _size = 0;
    }

    /**
     * Returns a string representation of the list.
     *
     * @return String
     */
    public String toString() {
        String result = "[ ";
        for(int i = 0; i < size(); i++)
            result += _list[i] + " ";
        result += "]";

        return result;
    }
}
