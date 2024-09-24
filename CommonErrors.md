# No template found for index

When running Vapor from Xcode, you must manually configure the working directory to point to the project’s root folder, as Xcode sets the working directory to a different location by default. This can prevent Vapor from correctly locating templates and other resources.

## Steps to configure the working directory in Xcode:

1. **Open your project in Xcode**.

2. **Select the run scheme**:
   - In Xcode’s top bar, select the run scheme (usually an icon of your app with its name).

3. **Select "Edit Scheme"**:
   - From the dropdown menu, select **"Edit Scheme"**.

4. **Go to the "Run" tab** in the scheme.

5. **Go to "Options"** and look for the **"Working Directory"** option.

6. **Check the box** for **"Use custom working directory"**.

7. **Select the root directory** of your project:
   - Choose the root folder of your Vapor project where `Package.swift` is located.

## Result:

By doing this, Xcode will run your project in the correct root folder, and Leaf will be able to find the `index.leaf` template in `Resources/Views`.
