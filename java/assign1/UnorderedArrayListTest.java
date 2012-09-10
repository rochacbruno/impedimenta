package assign1;
import static org.junit.Assert.*;
import org.junit.Test;

/**
 * Unit tests for UnorderedArrayList
 *
 * @author ldamon
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class UnorderedArrayListTest {

    /**
     * Create and test an UnorderedArrayList&lt;Integer&gt;.
     */
    @Test
    public void addRemoveInteger() {
        // 0 elements. Test constructor
        UnorderedArrayList<Integer> list = new UnorderedArrayList<Integer>();
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 3 elements. Test insertEnd()
        for(int i = 0; i < 3; i++)
            list.insertEnd(i);
        assertTrue(3 == list.size());
        assertTrue(0 == list.get(0));
        assertTrue(1 == list.get(1));
        assertTrue(2 == list.get(2));
        assertTrue(0 == list.get(list.size() - 3));
        assertTrue(1 == list.get(list.size() - 2));
        assertTrue(2 == list.get(list.size() - 1));
        assertEquals("[ 0 1 2 ]", list.toString());

        // 0 elements. Test clear()
        list.clear();
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 3 elements. Test insertAt()
        for(int i = 0; i < 3; i++)
            list.insertAt(i, i);
        assertTrue(3 == list.size());
        assertTrue(0 == list.get(0));
        assertTrue(1 == list.get(1));
        assertTrue(2 == list.get(2));
        assertTrue(0 == list.get(list.size() - 3));
        assertTrue(1 == list.get(list.size() - 2));
        assertTrue(2 == list.get(list.size() - 1));
        assertEquals("[ 0 1 2 ]", list.toString());

        // 2 elements. Test remove()
        list.remove(2);
        assertTrue(2 == list.size());
        assertTrue(0 == list.get(0));
        assertTrue(1 == list.get(1));
        assertTrue(0 == list.get(list.size() - 2));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 0 1 ]", list.toString());
        // 1 element. Test remove()
        list.remove(0);
        assertTrue(1 == list.size());
        assertTrue(1 == list.get(0));
        assertTrue(1 == list.get(list.size() - 1));
        assertEquals("[ 1 ]", list.toString());
        // 0 elements. Test remove()
        list.remove(1);
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    /**
     * Create and test an UnorderedArrayList&lt;String&gt;.
     */
    @Test
    public void addRemoveString() {
        // 0 elements. Test constructor
        UnorderedArrayList<String> list = new UnorderedArrayList<String>();
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 3 elements. Test insertEnd()
        list.insertEnd("zero");
        list.insertEnd("one");
        list.insertEnd("two");
        assertTrue(3 == list.size());
        assertTrue("zero" == list.get(0));
        assertTrue("one"  == list.get(1));
        assertTrue("two"  == list.get(2));
        assertTrue("zero" == list.get(list.size() - 3));
        assertTrue("one"  == list.get(list.size() - 2));
        assertTrue("two"  == list.get(list.size() - 1));
        assertEquals("[ zero one two ]", list.toString());

        // 0 elements. Test clear()
        list.clear();
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 3 elements. Test insertAt()
        list.insertAt(0, "zero");
        list.insertAt(1, "one");
        list.insertAt(2, "two");
        assertTrue(3 == list.size());
        assertTrue("zero" == list.get(0));
        assertTrue("one"  == list.get(1));
        assertTrue("two"  == list.get(2));
        assertTrue("zero" == list.get(list.size() - 3));
        assertTrue("one"  == list.get(list.size() - 2));
        assertTrue("two"  == list.get(list.size() - 1));
        assertEquals("[ zero one two ]", list.toString());

        // 2 elements. Test remove()
        list.remove("two");
        assertTrue(2 == list.size());
        assertTrue("zero" == list.get(0));
        assertTrue("one"  == list.get(1));
        assertTrue("zero" == list.get(list.size() - 2));
        assertTrue("one"  == list.get(list.size() - 1));
        assertEquals("[ zero one ]", list.toString());
        // 1 element. Test remove()
        list.remove("zero");
        assertTrue(1 == list.size());
        assertTrue("one" == list.get(0));
        assertTrue("one" == list.get(list.size() - 1));
        assertEquals("[ one ]", list.toString());
        // 0 elements. Test remove()
        list.remove("one");
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());
    }

    /**
     * Create and test an UnorderedArrayList&lt;Person&gt;.
     */
    @Test
    public void addRemovePerson() {
        Person alice = new Person();
        Person bob = new Person("Bob");
        Person carl = new Person("Carl", 42);

        // 0 elements. Test constructor
        UnorderedArrayList<Person> list = new UnorderedArrayList<Person>();
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 3 elements. Test insertEnd()
        list.insertEnd(alice);
        list.insertEnd(bob);
        list.insertEnd(carl);
        assertTrue(3 == list.size());
        assertTrue(alice == list.get(0));
        assertTrue(bob   == list.get(1));
        assertTrue(carl  == list.get(2));
        assertTrue(alice == list.get(list.size() - 3));
        assertTrue(bob   == list.get(list.size() - 2));
        assertTrue(carl  == list.get(list.size() - 1));
        assertEquals("[ (\"\", 0) (\"Bob\", 0) (\"Carl\", 42) ]", list.toString());

        // 0 elements. Test clear()
        list.clear();
        assertTrue(0 == list.size());
        assertEquals("[ ]", list.toString());

        // 3 elements. Test insertAt()
        list.insertAt(0, alice);
        list.insertAt(1, bob);
        list.insertAt(2, carl);
        assertTrue(3 == list.size());
        assertTrue(alice == list.get(0));
        assertTrue(bob   == list.get(1));
        assertTrue(carl  == list.get(2));
        assertTrue(alice == list.get(list.size() - 3));
        assertTrue(bob   == list.get(list.size() - 2));
        assertTrue(carl  == list.get(list.size() - 1));
        assertEquals("[ (\"\", 0) (\"Bob\", 0) (\"Carl\", 42) ]", list.toString());

        // 2 elements. Test remove()
        list.remove(carl);
        assertTrue(2 == list.size());
        assertTrue(alice == list.get(0));
        assertTrue(bob   == list.get(1));
        assertTrue(alice == list.get(list.size() - 2));
        assertTrue(bob   == list.get(list.size() - 1));
        assertEquals("[ (\"\", 0) (\"Bob\", 0) ]", list.toString());
        // 1 element. Test remove()
        list.remove(alice);
        assertTrue(1 == list.size());
        assertTrue(bob == list.get(0));
        assertTrue(bob == list.get(list.size() - 1));
        assertEquals("[ (\"Bob\", 0) ]", list.toString());
        // 0 elements. Test remove()
        list.remove(bob);
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
