
package helper;


public class RatingCount {
    
    public static float rcount(float star_count,float user)
    {
        String str = (star_count/user)+"";
       if(str.equals("NaN"))
       {
           return 0;
       }
      
       float rat = star_count/user;
       str=rat+"";
       if(str.length()>4)
       {
           str=str.substring(0,5);
           rat=Float.parseFloat(str);
           return rat;
       }
       return rat;
    }
    
}
