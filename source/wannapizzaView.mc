using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Time;
using Toybox.FitContributor;

class wannapizzaView extends WatchUi.DataField {
	hidden var kind_of_food;
////////////////////////////////////
    hidden var mValue;
////////////////////////////////////
    const METERS_TO_MILES = 0.000621371;
    const MILLISECONDS_TO_SECONDS = 0.001;

    const CALORIES_PER_SLICE = 288.0;
    
    var counter;
    var food_array = [ "Pizza", "Beer", "Soju" ];
    var current_pizzas_earned = 0.0;
    var label = "";

    var my_image;

	// Fit Contributor
	hidden var mFitContributor;
	var guiltFreePizzasField = null;
	const PIZZAS_FIELD_ID = 0;
	
    function initialize(foodnum) {

        DataField.initialize();
        label = "Pizzas";
        counter = 0;
        current_pizzas_earned = 0;
        kind_of_food = foodnum;
        
		guiltFreePizzasField = createField(
			"Guilt-free Pizzas",
			PIZZAS_FIELD_ID,
			FitContributor.DATA_TYPE_FLOAT,
			{:mesgType=>FitContributor.MESG_TYPE_RECORD, :units=>"slices"}
		);
		guiltFreePizzasField.setData(0.0);
				

//        DataField.initialize();
////////////////////////////////////
        mValue = 0.0f;
 ////////////////////////////////////
    }

    // Set your layout here. Anytime the size of obscurity of
    // the draw context is changed this will be called.
    function onLayout(dc) {


        var width = dc.getWidth();
        var height = dc.getHeight();

        

        if(width >=200)
        {
            if(height >= 100)
            { 
//                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100);
                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100n);

            }
            else
            {
                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey50n);
            }
            if(current_pizzas_earned >=2)
            {
                if(height >=100)
                {
                    my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100n);
                }
                else
                {
                    my_image = WatchUi.loadResource(Rez.Drawables.id_monkey50n);
                }
                
            }
            if(current_pizzas_earned >=3)
            {
                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100n);
            }
            
        }
        else if(width >=160)
        {
            my_image = WatchUi.loadResource(Rez.Drawables.id_monkey50n);
        }
        else 
        {
            my_image = WatchUi.loadResource(Rez.Drawables.id_monkey40n);
        }    
    
    
    
    
    
    
    
        var obscurityFlags = DataField.getObscurityFlags();

        // Top left quadrant so we'll use the top left layout
        if (obscurityFlags == (OBSCURE_TOP | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));

        // Top right quadrant so we'll use the top right layout
        } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.TopRightLayout(dc));

        // Bottom left quadrant so we'll use the bottom left layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));

        // Bottom right quadrant so we'll use the bottom right layout
        } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));

        // Use the generic, centered layout
        } else {
            View.setLayout(Rez.Layouts.MainLayout(dc));
            var labelView = View.findDrawableById("label");
            labelView.locY = labelView.locY - 16;
            var valueView = View.findDrawableById("value");
            valueView.locY = valueView.locY + 7;
        }

        View.findDrawableById("label").setText(Rez.Strings.label);
        return true;
    }

    // The given info object contains all the current workout information.
    // Calculate a value and save it locally in this method.
    // Note that compute() and onUpdate() are asynchronous, and there is no
    // guarantee that compute() will be called before onUpdate().
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        var calories = 0;

        if(info.calories != null)
        {
            //calories = info.calories*100;
            calories = info.calories;
            
        }
        
        current_pizzas_earned = (calories / CALORIES_PER_SLICE);
        /* current_pizzas_earned = (calories / CALORIES_PER_SLICE); */
        
        if(current_pizzas_earned == null)
        {
            
            current_pizzas_earned = 0;
        }
        
        /* current_pizzas_earned = calories / 650.0; */
        System.println("CALORIES === "+calories.toString());
        System.println("PIZZAS === "+current_pizzas_earned.toString());
        System.println(kind_of_food);
        

		if(info != null && info.calories != null) 
		{
			guiltFreePizzasField.setData(current_pizzas_earned.toFloat());
			System.println("SAVE TO FIT");
		}
		


///////////////////////////
        if(info has :currentHeartRate){
            if(info.currentHeartRate != null){
                mValue = info.currentHeartRate;
            } else {
                mValue = 0.0f;
            }
        }
        return current_pizzas_earned;
//////////////////////////////
    }



    function draw_pizza(x, y, my_image, pizza_num, dc)
    {
        var image_height = my_image.getHeight();
        var image_width = my_image.getWidth();
        /* dc.drawBitmap(width/2-image_width/2,height/2-image_height/2, my_image); */
        dc.drawBitmap(x,y, my_image);
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        var ratio = 0.0;

        ratio = image_width*0.9 - ((pizza_num) * (image_width*0.7));
        
        /* ratio = image_width - ((pizza_num) * (image_width+1)) - (image_width*0.1); */
        /* var cover_ratio = (1.0-pizza_num)*(image_width*0.09); */
        /* ratio = image_width - cover_ratio; */
        
        /* ratio = image_width - cover_ratio + (image_width*0.09); */
        
        
        var circle_x = x+(image_width*0.05);
        var circle_y = y+image_height +(image_width*0.13);
            
        dc.fillCircle(circle_x, circle_y, ratio);
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
    
    
         System.println("onUpdate Start");
        /* View.findDrawableById("Background").setColor(getBackgroundColor()); */
        var width = dc.getWidth();
        var height = dc.getHeight();

//        
//
//        if(width >=200)
//        {
//            if(height >= 100)
//            { 
////                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100);
//                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100n);
//            }
//            else
//            {
//                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey50n);
//            }
//            if(current_pizzas_earned >=2)
//            {
//                if(height >=100)
//                {
//                    my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100n);
//                }
//                else
//                {
//                    my_image = WatchUi.loadResource(Rez.Drawables.id_monkey50n);
//                }
//                
//            }
//            if(current_pizzas_earned >=3)
//            {
//                my_image = WatchUi.loadResource(Rez.Drawables.id_monkey100n);
//            }
//            
//        }
//        else if(width >=160)
//        {
//            my_image = WatchUi.loadResource(Rez.Drawables.id_monkey50n);
//        }
//        else 
//        {
//            my_image = WatchUi.loadResource(Rez.Drawables.id_monkey40n);
//        }
        var image_height = my_image.getHeight();
        var image_width = my_image.getWidth();
            

        System.println("=========");
        System.println(width);
        System.println(height);
        System.println("=========");

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);

        dc.clear();

        if(current_pizzas_earned <= 0.01)
        {
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
            dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_SMALL, "Pizza?\nGo!Go!", (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
        }
        
        else if(current_pizzas_earned <= 1)
        {
            /* dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_RED); */
            /* dc.drawPoint(circle_x, circle_y); */
            draw_pizza(width/2-image_width/2, height/2-image_height/2, my_image, current_pizzas_earned ,dc);
        /* dc.drawBitmap(width/2-image_width/2,height/2-image_height/2, my_image); */
            
        }
        else if(current_pizzas_earned <=2)
        {
            draw_pizza((dc.getWidth()/2) - image_width+(image_width*0.10),dc.getHeight()/2-image_height/2, my_image, current_pizzas_earned-1, dc);
            dc.drawBitmap((dc.getWidth()/2) + (image_width*0.05),dc.getHeight()/2-image_height/2, my_image);
            /* dc.drawBitmap((dc.getWidth()/2) - image_width-(image_width*0.03),dc.getHeight()/2-image_height/2, my_image); */
        }
        
        else if(current_pizzas_earned <=3)
        {
            draw_pizza((dc.getWidth()/3)*0 +(image_width*0.04),dc.getHeight()/2-image_height/2, my_image, current_pizzas_earned-2, dc);
            dc.drawBitmap((dc.getWidth()/3)*1 +(image_width*0.08),dc.getHeight()/2-image_height/2, my_image);
            dc.drawBitmap((dc.getWidth()/3)*2 +(image_width*0.02),dc.getHeight()/2-image_height/2, my_image);
        }
        else{
        

            /* System.println(dc.getWidth()); */
            /* System.println(dc.getHeight()); */
        
            /* System.println(image_height); */
            /* System.println(image_width); */
        
            /* System.println(dc.getWidth()/2+image_width); */
            /* System.println(dc.getHeight()/2-image_height/2); */
        
            dc.drawBitmap((dc.getWidth()/4)*2 - image_width+(image_width*0.01),dc.getHeight()/2-image_height/2, my_image);
        
            dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
            var num_of_pizzas = current_pizzas_earned.format("%.01f");
            var what_font = Graphics.FONT_MEDIUM;
            
            if(dc.getWidth() >= 200)
            {
                what_font = Graphics.FONT_LARGE;
            }
            else
            {
            }
            dc.drawText(3*(dc.getWidth()/4) , dc.getHeight()/2, what_font, "X "+num_of_pizzas, (Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER));
        }
        
    
//        // Set the background color
//        View.findDrawableById("Background").setColor(getBackgroundColor());
//
//        // Set the foreground color and value
//        var value = View.findDrawableById("value");
//        if (getBackgroundColor() == Graphics.COLOR_BLACK) {
//            value.setColor(Graphics.COLOR_WHITE);
//        } else {
//            value.setColor(Graphics.COLOR_BLACK);
//        }
//        value.setText(mValue.format("%.2f"));
//
//        // Call parent's onUpdate(dc) to redraw the layout
//        View.onUpdate(dc);
    }

}
