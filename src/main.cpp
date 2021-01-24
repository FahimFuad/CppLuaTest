#include <iostream>
#include <string>

extern "C"
{
    #include <lua.h>
    #include <lauxlib.h>
    #include <lualib.h>
}

bool CheckLua(lua_State* L, int r)
{
    if (r != LUA_OK)
    {
        std::string errorMsg = lua_tostring(L, -1);
        std::cout << errorMsg << std::endl;
        return false;
    }
    return true;
}

int lua_HostFunction(lua_State* L)
{
    float a =  (float)lua_tonumber(L, 1);
    float b =  (float)lua_tonumber(L, 2);

    std::cout << "[C++] HostFunction(" << a << ", "<< b << ") called!" << std::endl;
    float c = a * b;
    lua_pushnumber(L, c);
    return 1;
}

int main()
{
    struct Player
    {
        std::string Title;
        std::string Name;
        std::string Status;
        int Level;
    };
    Player player;

    lua_State* L = luaL_newstate();
    luaL_openlibs(L);

    lua_register(L, "HostFunction", lua_HostFunction);

    if (CheckLua(L, luaL_dofile(L, "src/Lua/Test.lua")))
    {
        lua_getglobal(L, "DoAThing");
        if (lua_isfunction(L, -1))
        {
            lua_pushnumber(L, 5);
            lua_pushnumber(L, 6);

            if (CheckLua(L, lua_pcall(L, 2, 1, 0)))
            {
                std::cout << "[C++] HostFunction(5, 6) got " << (float)lua_tonumber(L, -1) << std::endl;
            }
        }
    }

    std::cin.get();
    lua_close(L);
    return 0;
}

/*if (CheckLua(L, luaL_dofile(L, "src/Lua/Test.lua")))
{
    lua_getglobal(L, "player");
    if (lua_istable(L, -1))
    {
        lua_pushstring(L, "Name");
        lua_gettable(L, -2);
        player.Name = lua_tostring(L, -1);
        lua_pop(L, 1);


        lua_pushstring(L, "Title");
        lua_gettable(L, -2);
        player.Title = lua_tostring(L, -1);
        lua_pop(L, 1);


        lua_pushstring(L, "Status");
        lua_gettable(L, -2);
        player.Status = lua_tostring(L, -1);
        lua_pop(L, 1);


        lua_pushstring(L, "Level");
        lua_gettable(L, -2);
        player.Level = (int)lua_tonumber(L, -1);
        lua_pop(L, 1);
    }
}

std::cout << "Title  = " << player.Title << std::endl;
std::cout << "Name   = " << player.Name << std::endl;
std::cout << "Status = " << player.Status << std::endl;
std::cout << "Level  = " << player.Level << std::endl;*/