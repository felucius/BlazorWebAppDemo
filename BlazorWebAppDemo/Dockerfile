# STAGE 1: Build the application
FROM ://mcr.microsoft.com AS build
WORKDIR /src

# Copy the project file and restore dependencies
# This is "YourProjectFolder/YourProjectName.csproj"
COPY ["BlazorWebAppDemo/BlazorWebAppDemo.csproj", "BlazorWebAppDemo/"]
RUN dotnet restore "BlazorWebAppDemo/BlazorWebAppDemo.csproj"

# Copy the entire source and build
COPY . .
WORKDIR "/src/BlazorWebAppDemo"
RUN dotnet build "BlazorWebAppDemo.csproj" -c Release -o /app/build

# STAGE 2: Publish the application
FROM build AS publish
RUN dotnet publish "BlazorWebAppDemo.csproj" -c Release -o /app/publish /p:UseAppHost=false

# STAGE 3: Final runtime image
FROM ://mcr.microsoft.com AS final
WORKDIR /app
# .NET 8+ defaults to port 8080
EXPOSE 8080
EXPOSE 8081
COPY --from=publish /app/publish .

# Replace YourProjectName.dll with your actual output dll
ENTRYPOINT ["dotnet", "BlazorWebAppDemo.dll"]
