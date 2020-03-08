# The Book of Shaders - Godot
[The Book of Shaders](https://thebookofshaders.com/) ported to [Godot](https://www.godotengine.org/) by J.R. Robinson

A learning resource for shader development.

[Godot shading language](https://docs.godotengine.org/en/latest/tutorials/shading/shading_reference/shading_language.html)

[Migrate to Godot's Shading Language](https://docs.godotengine.org/en/latest/tutorials/shading/migrating_to_godot_shader_language.html)

Shout out to: [glslViewer](https://github.com/patriciogonzalezvivo/glslViewer)

## Installation and Use
#### Option A
Download from releases

#### Option B
```
git clone https://github.com/jayaarrgh/BookOfShaders-Godot.git
cd BookOfShaders-Godot
```
Open with Godot 3.2

Export the project on your platform and use the executable.

or

Run the Main.tscn. Use the file dialog to switch shaders.

## Tips
The hideable text editor swaps the shader code every 200 ms, and saves the file every 3000ms.

The reset button returns edited shaders to their default code.

![](.gif/demo.gif)

To reset all shaders to the default shader code, delete the shaders folder in the user directory and reopen the application.

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

