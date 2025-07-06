public class FutureDemo {
    @future
    public static void doWork(List<String> accList)
    {
        System.debug('Future method called');
        //List<Account> accList = new List<Account>();
        doSleep(new List<String>{'keerthi'});
    }
    
    @future
    public static void doSleep(List<String> accList)
    {
        System.debug('Future method sleep');
    }
    

}