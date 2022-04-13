using Toybox.Application;
using Toybox.System;


class wannapizzaApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
         System.println("Hello Monkey C!");
         if(getProperty("nKindOfFood") == null)
         {
         	setProperty("nKindOfFood", 1);
         }
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    //! Return the initial view of your application here
    function getInitialView() {
		var app = Application.getApp();
		var kind_of_food = app.getProperty("nKindOfFood");
		if(kind_of_food == null)
		{
			kind_of_food = 1;
		}
        return [ new wannapizzaView(kind_of_food) ];
    }

}