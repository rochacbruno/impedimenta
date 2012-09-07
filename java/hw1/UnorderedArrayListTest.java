package assign1;

import static org.junit.Assert.*;

import org.junit.Test;

/**
 * @author ldamon
 *
 */
public class UnorderedArrayListTest {


	
	/**
	 * 
	 */
	@Test
	public void addTwoIntegers()
	{
		UnorderedArrayList list = new UnorderedArrayList();
		list.insertEnd(1);
		int result = list.get(0);
		assertTrue(result == 1);
		result = list.get(list.size() - 1);
		assertTrue(result == 1);
		int size = list.size();
		assertTrue(size == 1);
		
		list.insertEnd(2);
		result = list.get(0);
		assertTrue(result == 1);
		result = list.get(list.size() - 1);
		assertTrue(result == 2);
		size = list.size();
		assertTrue("expected 2, received "+size,size == 2);
		System.out.println("Printing list: expect list with two elements '1  2'");
		System.out.println(list);
		
		list.remove(2);
		size = list.size();
		assertTrue(size == 1);
		result = list.get(0);
		assertTrue(result == 1);
		result = list.get(list.size()-1);
		assertTrue(result == 1);
		
		System.out.println("Printing list: expect list with 1 element '1'");
		System.out.println(list);
		
		list.remove(1);
		size = list.size();
		assertTrue(size == 0);
		
		System.out.println("Printing list: expect list with 0 elements");
		System.out.println(list);
		
	}
	
	/**
	 * 
	 */
	@Test
	public void addThreeIntegers()
	{
		UnorderedArrayList list = new UnorderedArrayList();
		list.insertEnd(1);
		int result = list.get(0);
		assertTrue(result == 1);
		result = list.get(list.size()-1);
		assertTrue(result == 1);
		int size = list.size();
		assertTrue(size == 1);
		
		list.insertEnd(2);
		result = list.get(0);
		assertTrue(result == 1);
		result = list.get(list.size()-1);
		assertTrue(result == 2);
		size = list.size();
		assertTrue("expected 2, received "+size,size == 2);
		System.out.println("Printing list: expect list with two elements '1  2'");
		System.out.println(list);
		
		list.insertEnd(3);
		result = list.get(0);
		assertTrue(result == 1);
		result = list.get(list.size()-1);
		assertTrue(result == 3);
		size = list.size();
		assertTrue("expected 3, received "+size,size == 3);
		System.out.println("Printing list: expect list with two elements '1  2  3'");
		System.out.println(list);

		
		list.remove(1);
		size = list.size();
		assertTrue(size == 2);
		result = list.get(0);
		assertTrue(result == 2);
		result = list.get(list.size()-1);
		assertTrue(result == 3);

		System.out.println("Printing list: expect list with 2 element '2  3'");
		System.out.println(list);
	
		list.remove(2);
		size = list.size();
		assertTrue(size == 1);
		result = list.get(0);
		assertTrue("expected 3, received "+result, result == 3);
		result = list.get(list.size()-1);
		assertTrue(result == 3);

		System.out.println("Printing list: expect list with 1 element '3'");
		System.out.println(list);
		
		list.remove(3);
		size = list.size();
		assertTrue(size == 0);
		
		System.out.println("Printing list: expect list with 0 elements");
		System.out.println(list);
		
	}
	/**
	 * 
	 */
	@Test 
	public void testEmptyList()
	{
		UnorderedArrayList emptyList = new UnorderedArrayList();
		
		boolean result = emptyList.remove(1);
		assertTrue(result == false);
	}
	
	/**
	 * 
	 */
	@Test (expected=IndexOutOfBoundsException.class)
	public void testEmptyListGet()
	{
		UnorderedArrayList emptyList = new UnorderedArrayList();
		
		emptyList.get(emptyList.size()-1);
	}
}

