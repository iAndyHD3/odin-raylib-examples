package main

import rl "vendor:raylib"

main :: proc() {

    screenWidth :: 800
    screenHeight :: 450

    rl.InitWindow(screenWidth, screenHeight, "raylib [core] example - basic window")

    rl.SetTargetFPS(60)

    camera := rl.Camera2D {
        zoom = 1
    }


    for !rl.WindowShouldClose() {
        //UPDATE

        if rl.IsMouseButtonDown(rl.MouseButton.RIGHT) {
            delta: rl.Vector2 = rl.GetMouseDelta()

            //raymath is not in vendor libs yet
            //Vector2Scale(delta, -1 / camera.zoom)
            delta.x *= -1 / camera.zoom
            delta.y *= -1 / camera.zoom

            //camera.target = Vector2Add(camera.target, delta)
            camera.target.x += delta.x
            camera.target.y += delta.y
        }

        wheel: f32 = rl.GetMouseWheelMove()
        if wheel != 0 {
            mouseWorldPos: rl.Vector2 = rl.GetScreenToWorld2D(rl.GetMousePosition(), camera)
            camera.offset = rl.GetMousePosition()
            camera.target = mouseWorldPos

            zoomIncrement :: 0.125

            camera.zoom += wheel * zoomIncrement
            if camera.zoom < zoomIncrement do camera.zoom = zoomIncrement
        }
        //Draw
        rl.BeginDrawing()
        defer rl.EndDrawing()

        rl.ClearBackground(rl.BLACK)
        {
            rl.BeginMode2D(camera)
            defer rl.EndMode2D()
            {
                rl.rlPushMatrix()
                defer rl.rlPopMatrix()

                rl.rlTranslatef(0, 25 * 50, 0)
                rl.rlRotatef(90, 1, 0, 0)
                rl.DrawGrid(100, 50)
            }
            rl.DrawCircle(100, 100, 50, rl.YELLOW)
        }
        rl.DrawText("Mouse right button drag to move, mouse wheel to zoom", 10, 10, 20, rl.WHITE)
    }
}