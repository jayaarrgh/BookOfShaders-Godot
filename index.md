# The Book of Shaders - Godot
[The Book of Shaders](https://thebookofshaders.com/) ported to [Godot](https://www.godotengine.org/) by J.R. Robinson

A learning resource for shader development.

Now featuring a 3D section for additional learning! Use middle mouse button click and drag to swing the camera around the mesh in 3d view.

[Godot shading language](https://docs.godotengine.org/en/stable/tutorials/shading/shading_reference/shading_language.html)

[Migrate to Godot's Shading Language](https://docs.godotengine.org/en/stable/tutorials/shading/migrating_to_godot_shader_language.html#doc-migrating-to-godot-shader-language)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/donate/?business=L4GGSCN5YWVG2&no_recurring=0&item_name=Thanks+for+buying+me+a+coffee%21&currency_code=USD)

![](.gif/demo.gif)

## Installation
#### Option A
Download from releases or at [itch](https://jayaarrgh.itch.io/book-of-shaders-godot)

#### Option B
```
git clone https://github.com/jayaarrgh/BookOfShaders-Godot.git
cd BookOfShaders-Godot
```
Open with **Godot 3.4**

Export the project on your platform and use the executable.

or

Run the Main.tscn. Use the file dialog to switch shaders.


## Tips on Use
The hideable text editor swaps the shader code every 200 ms, and saves the file every 3000ms.
It does this less often in the 3D section, as saving and swaping shaders in 3d takes a bit longs and causes slight pauses in the renderer.

The 3D section can load 2d canvas shaders with strange results.
All 3D shaders should go inside the shader folder.

The reset button returns edited shaders to their default code.

To reset all shaders to the default shader code, delete the shaders folder in the user directory and reopen the application. Copy any of your changes you want to maintain first of course.

Create new folders and new shader code in the user directory.

*WARNING*: Automatic saving during runtime will overwrite external editor changes.
If using an external text editor, this application should be closed first.


#### User Directory

    Windows:
        %APPDATA%\Godot\app_userdata\Project Name

    On GNU/Linux: 
        $HOME/.godot/app_userdata/Project Name
        OR
        $HOME/.local/share/godot/app_userdata/Project Name

## ChangeLog
### v2
- Added 3d Mode
- Used Godot 3.4 (from 3.2 in v1)
- *.shader were renamed *.gdshader
