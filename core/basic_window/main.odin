package main

import rl "vendor:raylib"

main :: proc() {

    screenWidth :: 800
    screenHeight :: 450

    rl.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window")

    rl.SetTargetFPS(60)

    for !rl.WindowShouldClose() {
        //UPDATE
        //update your variables here

        //Draw
        rl.BeginDrawing()
        defer rl.EndDrawing()

        rl.ClearBackground(rl.RAYWHITE)
        rl.DrawText("Congrats! You created your first window!", 190, 200, 20, rl.LIGHTGRAY)
    }
}