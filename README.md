# garmin-todotxt

Because I use todotxt, and I want the convenience of checking today's tasks from my garmin.

You probably have to create the api endpoint yourself, but the code works with following api response:

```json
[
  { "id": 1, "todo": "foo" },
  { "id": 2, "todo": "bar" }
]
```

Then when you build the app, edit values in `source/GarminTodotxtWidgetApp.mc`, then copy the app to your device.

## Screenshot

![screenshot](docs/screenshot.webp)
