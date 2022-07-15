import os
import std/json

var 
    commandFile: string
    commandData: JsonNode

try:
    commandFile = readFile("commands.json")
    commandData = parseJson(commandFile)
    #echo "[Debug]: Command file loaded successfully" #this can be used to verify your JSON loaded successfully, if you have a JSON error for example, it will fail at the 'except' below.
except:
    echo "Something went wrong when loading 'commands.json', please re-clone the repo."
    quit 1
#this is best practices, right?

proc repl(prompt: string)=
    while true:
        stdout.write(prompt)
        var command = readLine(stdin)


        if command == "exit":
            quit 0
        elif command == "clear":
            try:
                discard execShellCmd("cls")
            except:
                discard execShellCmd("clear")
            #SURELY this will work SURELY (haven't tested on *nix, probably won't tbh)
        else:
            try:
                let responseData = commandData["commands"][command]

                #since the only test command I have is ping, I'm going to base the next line off of that
                echo responseData["response"].getStr()



                #your code here
            except:
                
                echo command & " not found in 'commands.json'. Verify your command exists, add it, or try another command."
        




proc main() =
    let prompt = "REPL -> "
    repl(prompt)
main()