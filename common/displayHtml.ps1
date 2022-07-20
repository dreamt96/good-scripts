using namespace System.Windows.Forms
using namespace System.Drawing

param($div = "<div>hello world</div>")

# Load the WinForms assembly.
Add-Type -AssemblyName System.Windows.Forms

# Create a form.
$form = [Form] @{
  ClientSize = [Point]::new(400, 400)
  Text       = "WebBrowser-Control Demo"
}

# Create a web-browser control, make it as large as the inside of the form,
# and assign the HTML text.
$html = '
<!DOCTYPE html>
<html lang="de">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Title</title>
  </head>
  <body>
    ${0}
  </body>
</html>
'
$wb = [WebBrowser] @{
  ClientSize   = $form.ClientSize
  DocumentText = & 'common/messageFormat.ps1' -format $html -parameters $div
}

# Add the web-browser control to the form...
$form.Controls.Add($wb)

# ... and display the form as a dialog (synchronously).
$form.ShowDialog()

# Clean up.
$form.Dispose()