({
    /*doInit : function(c, e, h){
        console.log('====doInit======');
        c.set('v.selectedTab','about');
    },*/
    changeTab : function(c, e, h) {
        console.log('===filters===',e);
        var filters = e.getParam('selectedtab');
        console.log('===filters1===',filters);
        c.set('v.selectedTab',filters);
    }
})