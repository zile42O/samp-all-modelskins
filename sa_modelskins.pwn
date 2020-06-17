/*  Filterscript/Include:
        sa_modelskins.inc
    Info:
        I did this as follows, to avoid array and formatting in the code, 
        I created a .db file containing the format from the mysql database from 
        the official samp wiki on all skins, and then formatted that 
        .db file and did a simple and short part of the script, 
        ie. code that goes through a .db file and loads values ​​and information.
        I did this for myself but I also decided to share it publicly, it will serve someone.
    Author:
        Aleksandar Zivkovic (zile42O)
    Duration:   
        About 15 min
    Release date:
        6/17/2020                                                                     
*/
#include    <a_samp>
#include    <sscanf2>
#define     MAX_SKIN_MODELS (312)

enum E_SKINS_DATA
{ 
    skin_id, 
    skin_model_name[255], 
    skin_name_type[255], 
    singleplayer_location[255], 
    gender[255]
};

new SkinModelsArray[MAX_SKIN_MODELS][E_SKINS_DATA];

stock SkinModelsInit()
{
    print("\r\nLoading skin models and informations from database...");
    new index, line[256], File:file_ptr;

    file_ptr = fopen("skins.db", filemode:io_read);

    if(!file_ptr) return print("\r\nError: Can't find > skins.db");
    while(fread(file_ptr, line) > 0) {
        new tempcolumn;
        if(!sscanf(line, "p<|>dds[255]s[255]s[255]s[256]",
        tempcolumn,  
        SkinModelsArray[index][skin_id], 
        SkinModelsArray[index][skin_model_name], 
        SkinModelsArray[index][skin_name_type],
        SkinModelsArray[index][singleplayer_location], 
        SkinModelsArray[index][gender])) 
        {
            /*printf("\r\nDebug: skin_id:%i, skin_model_name: %s, skin_name_type: %s, singleplayer_location: %s, gender: %s ", 
            SkinModelsArray[index][skin_id], 
            SkinModelsArray[index][skin_model_name], 
            SkinModelsArray[index][skin_name_type],
            SkinModelsArray[index][singleplayer_location], 
            SkinModelsArray[index][gender]);*/          
            index++;
        }
    }
    fclose(file_ptr);
    printf("\r\nSuccess: Loaded %i skin models.", index);
    return 1;
}
//EXAMPLE:
public OnGameModeInit()
{
    SkinModelsInit();
    return true;  
}