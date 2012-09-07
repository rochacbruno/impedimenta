// Run junit tests from the command line with the following:
// javac -cp .:/usr/share/java/junit.jar assign1/*.java
// java -cp .:/usr/share/java/junit.jar org.junit.runner.JUnitCore assign1.UnorderedArrayListTest
package assign1;
import static org.junit.Assert.*;
import org.junit.Test;

/**
 * Unit tests for UnorderedArrayList
 *
 * @author ldamon
 * @author Jeremy Audet <ichimonji10@gmail.com>
 */
public class UnorderedArrayListTest {

    /**
     * Create an UnorderedArrayList<Integer>. Add elements to end using
     * insertEnd(), and remove using remove().
     */
    @Test
    public void addTwoIntegers() {
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 element
        list.insertEnd(1);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());

        // 2 elements
        list.insertEnd(2);
        assertTrue(2 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 2));
        assertTrue(2 == list.get(1));
        assertTrue(2 == list.get(list.size() - 1));
        assertEquals("[ 1 2 ]", list.toString());

        // 1 element
        list.remove(2);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());

        // 0 elements
        list.remove(1);
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    /**
     * Create an UnorderedArrayList<Integer>. Add elements to end using
     * insertAt(), and remove using remove().
     */
    @Test
    public void addThreeIntegers() {
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 elements
        list.insertAt(0, 1);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());

        // 2 elements
        list.insertAt(1, 2);
        assertTrue(2 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 2));
        assertTrue(2 == list.get(1));
        assertTrue(2 == list.get(list.size() - 1));
        assertEquals("[ 1 2 ]", list.toString());

        // 3 elements
        list.insertAt(2, 3);
        assertTrue(3 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 3));
        assertTrue(2 == list.get(1));
        assertTrue(2 == list.get(list.size() - 2));
        assertTrue(3 == list.get(2));
        assertTrue(3 == list.get(list.size() - 1));
        assertEquals("[ 1 2 3 ]", list.toString());

        // 2 elements
        list.remove(1);
        assertTrue(2 == list.size());
        assertTrue(2 == list.get(0));
        assertTrue(2 == list.get(list.size() - 2));
        assertTrue(3 == list.get(1));
        assertTrue(3 == list.get(list.size() - 1));
        assertEquals("[ 2 3 ]", list.toString());

        // 1 elements
        list.remove(2);
        assertTrue(1 == list.size());
        assertTrue(3 == list.get(0));
        assertTrue(3 == list.get(list.size() - 1));
        assertEquals("[ 3 ]", list.toString());

        // 0 elements
        list.remove(3);
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    /**
     * Create an UnorderedArrayList<String>. Add elements to end using
     * insertEnd(), and remove using remove().
     */
    @Test
    public void addTwoStrings() {
        UnorderedArrayList<String> list = new UnorderedArrayList<String>();

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 element
        list.insertEnd("one");
        assertTrue(1 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 1));
        assertEquals("[ one ]", list.toString());

        // 2 elements
        list.insertEnd("two");
        assertTrue(2 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 2));
        assertTrue("two" == list.get(1));
        assertTrue("two" == list.get(list.size() - 1));
        assertEquals("[ one two ]", list.toString());

        // 1 element
        list.remove("two");
        assertTrue(1 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 1));
        assertEquals("[ one ]", list.toString());

        // 0 elements
        list.remove("one");
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    /**
     * Create an UnorderedArrayList<String>. Add elements to end using
     * insertAt(), and remove using remove().
     */
    @Test
    public void addThreeStrings() {
        UnorderedArrayList<String> list = new UnorderedArrayList<String>();

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 element
        list.insertAt(0, "one");
        assertTrue(1 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 1));
        assertEquals("[ one ]", list.toString());

        // 2 elements
        list.insertAt(1, "two");
        assertTrue(2 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 2));
        assertTrue("two" == list.get(1));
        assertTrue("two" == list.get(list.size() - 1));
        assertEquals("[ one two ]", list.toString());

        // 3 elements
        list.insertAt(2, "three");
        assertTrue(3 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 3));
        assertTrue("two" == list.get(1));
        assertTrue("two" == list.get(list.size() - 2));
        assertTrue("three" == list.get(2));
        assertTrue("three" == list.get(list.size() - 1));
        assertEquals("[ one two three ]", list.toString());

        // 2 elements
        list.remove("one");
        assertTrue(2 == list.size());
        assertTrue("two" == list.get(0));
        assertTrue("two" == list.get(list.size() - 2));
        assertTrue("three" == list.get(1));
        assertTrue("three" == list.get(list.size() - 1));
        assertEquals("[ two three ]", list.toString());

        // 1 elment
        list.remove("two");
        assertTrue(1 == list.size());
        assertTrue("three" == list.get(0));
        assertTrue("three" == list.get(list.size() - 1));
        assertEquals("[ three ]", list.toString());

        // 0 elements
        list.remove("three");
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    @Test
    public void addThreePersons() {
        UnorderedArrayList<Person> list = new UnorderedArrayList<Person>();

        Person personOne = new Person();
        Person personTwo = new Person("Alice");
        Person personThree = new Person("Bob", 42);

        // 0 elements
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 1 element
        list.insertEnd(personOne);
        assertTrue(1 == list.size());
        assertTrue(new Person().contentsEqual(list.get(0)));
        assertEquals("[ (\"\", 0) ]", list.toString());

        // 2 elements
        list.insertEnd(personTwo);
        assertTrue(2 == list.size());
        assertTrue(new Person().contentsEqual(list.get(0)));
        assertTrue(new Person("Alice").contentsEqual(list.get(1)));
        assertEquals("[ (\"\", 0) (\"Alice\", 0) ]", list.toString());

        // 3 elements
        list.insertEnd(personThree);
        assertTrue(3 == list.size());
        assertTrue(new Person().contentsEqual(list.get(0)));
        assertTrue(new Person("Alice").contentsEqual(list.get(1)));
        assertTrue(new Person("Bob", 42).contentsEqual(list.get(2)));
        assertEquals("[ (\"\", 0) (\"Alice\", 0) (\"Bob\", 42) ]", list.toString());

        // 0 elements
        list.remove(personOne);
        list.remove(personTwo);
        list.remove(personThree);
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    @Test
    public void testBadAgeException1() {
        Person myPerson = new Person("foo", 5);
        assertEquals("(\"foo\", 5)", myPerson.toString());
    }

    @Test (expected = PersonAgeException.class)
    public void testBadAgeException2() {
        new Person("foo", -5);
    }

    @Test 
    public void testEmptyList() {
        UnorderedArrayList<Integer> emptyList = new UnorderedArrayList<Integer>();

        assertTrue(false == emptyList.remove(1));
    }

    @Test (expected = IndexOutOfBoundsException.class)
    public void testEmptyListGet() {
        UnorderedArrayList<Integer> emptyList = new UnorderedArrayList<Integer>();

        emptyList.get(emptyList.size() - 1);
    }
}
