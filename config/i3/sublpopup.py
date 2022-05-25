import asyncio
from i3ipc import Event
from i3ipc.aio import Connection

async def on_new_window(i3, e):
    print(f'a new window opened: {e.container.window_class} - {e.container.geometry.width} {e.container.geometry.height}')
    if e.container.window_class == "Sublime_text" and e.container.geometry.width == 596 and e.container.geometry.height == 185:
        await e.container.command('kill')

async def main():
    i3 = await Connection().connect()
    i3.on(Event.WINDOW_NEW, on_new_window)

    await i3.main()
    
asyncio.run(main())
