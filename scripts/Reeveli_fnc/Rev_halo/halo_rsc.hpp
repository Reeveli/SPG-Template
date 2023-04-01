class RscTitles {
    class Halo_mask {
        idd = -1;
        controls[] = {"Picture"};		
        duration = 100000;
        class Picture
        {
            x=safeZoneX;
            y=safeZoneY;
            w=safeZoneW;
            h=safeZoneH;
            idc = -1;
            text = "scripts\Reeveli_fnc\Rev_halo\images\al_helmet2.paa";

            deletable = 0;
            fade = 0;
            access = 0;
            type = CT_STATIC;
            style = ST_MULTI + ST_TITLE_BAR;
            colorBackground[] = {0,0,0,0};
            colorText[] = {1,1,1,1};
            font = "TahomaB";
            sizeEx = 0;
            lineSpacing = 0;
            fixedWidth = 0;
            shadow = 0;
            tooltipColorText[] = {1,1,1,1};
            tooltipColorBox[] = {1,1,1,1};
            tooltipColorShade[] = {0,0,0,0.65};
        };
    };
};
