
package assign1;

/**
 * 
 * @author Leslie Damon
 * Sample non-generic implementation of an unordered list of ints
 */
public class UnorderedArrayList implements UnorderedList{

	/**
	 * _list will actually hold the elements, currently implemented as an array
	 * _size is the amount of the array that is actually in use -- the number of elements.
	 */
	private Integer[] _list;
	private int _size;
	
	/**
	 * Constructor for the unordered list. 
	 * @param capacity the maximum size of the list
	 */
	public UnorderedArrayList(int capacity) 
	{
		_list = new Integer[capacity];
	}

	/**
	 * Constructor for the unordered list.
	 * This function creates a list with a (default) max capacity of 25
	 */
	public UnorderedArrayList() 
	{
		_list = new Integer[25];
	}


	/**
	 * InsertEnd adds the value at the end of the list. If the queue is full, an exception is thrown.
	 * @param value the value to insert
	 */
	public void insertEnd(int value) 
	{
		if(this.isFull())
		{
			throw new ListFullException();
		}
		else
		{
			_list[_size]= value;
			_size++;
		}
	}
	
	/**
	 * InsertEnd adds the value at the end of the list. If the queue is full, an exception is thrown.
	 * @param location the place to insert the element.  Locations range from 0 to size-1
	 * @param value the value to insert
	 */
	public void insertAt(int location, int value) 
	{
		if(this.isFull())
		{
			throw new ListFullException();
		}

		// only here if we have room to put another element in
		if (location > 0 && location < size())
		{
			for (int i = size(); i >= location; i--)
				_list[i+1] = _list[i];
			_list[location] = value;
			_size++;
		}
	}
	
	/**
	 * get the value at the specified location
	 * @param location
	 * @return the value
	 */
	public int get(int location)
	{
		if (location < 0 || location >= _size)
			throw new IndexOutOfBoundsException();
		else
			return _list[location];
	}

	/** 
	 * Find returns the index of the value matching the given value
	 * @param item the item to locate
	 * @return the index of the item or -1 if it doesn't exist
	 */
	public int indexOf(int item)
	{
		for (int i = 0; i < size(); i++)
		{
			if (_list[i] == item)
				return i;
		}
		return -1;  // if here, we didn't find it.
	}
	
	/**
	 * Remove the specified item.
	 * @param item to remove
	 * @return true if the item is found and removed, false if the item isn't found
	 */
	public boolean remove(int item)
	{
		int index = indexOf(item);
		if (index == -1)
			return false;
		
		// if here, we found the item.  Need to clean it up
		// we will do this by moving all the other elements over to the left to replace
		// the one we just removed
		for (int i = index; i < size()-1; i++)
		{
			_list[i] = _list[i+1];
		}
		_size--;
		return true;
	}


	/**
	 * The size method returns the number of elements found in the list.
	 * @return the size of the list at this time
	 */
	public int size() {
		
		return _size;
	}

	/**
	 * The isEmpty method checks if the list is empty. 
	 * @return true if the list is empty (has no elements), false otherwise
	 */
	public boolean isEmpty() {
		if (_size==0)
			return true;
		else
			return false;
	}
	

	/**
	 * The isFull method checks the list is full.
	 * @return true if the list has no room left, false if more elements can be inserted
	 */
	public boolean isFull() {
		if (_size == _list.length)
			return true;	
		else 
			return false;
	}
	
	/**
	 * Empty the list.
	 */
	public void clear()
	{
		_size = 0;
	}
	
	/**
	 * toString 
	 */
	public String toString()
	{
		String result = "[ ";
		for (int i = 0; i < size(); i++)
			result += _list[i] + " ";
		result += "]";
		return result;
	}

}
