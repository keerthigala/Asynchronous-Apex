public class Calculator {
    public static void doCalculate(integer x, integer y)
    {
        System.debug('Started Calculation');
        addition(x,y);
        subtraction(x,y);
        System.debug('Finished Calculation');
    }
    @future
    private static void addition(integer x, integer y)
    {
        System.debug('Addition :' + (x+y));
        for(integer i=1;i<=50000;i++){
            if(i==49000) {
                System.debug('I am in 49th iteration');
            }
        }
        //subtraction(x,y);   
    }
    
    private static void subtraction(integer x, integer y)
    {
        System.debug('Subtraction :' + (x-y));
        multiplication(x,y);     
    }
    
    private static void multiplication(integer x, integer y)
    {
        System.debug('Multiplication :' + (x*y));
        division(x,y);   
    }
    
    private static void division(integer x, integer y)
    {
        System.debug('Division :' + (x/y)); 
        
    }
}