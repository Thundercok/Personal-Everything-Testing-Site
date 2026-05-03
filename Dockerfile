FROM mcr.microsoft.com/dotnet/sdk:10.0-preview AS build
WORKDIR /src
COPY ["SchoolAppCoreRazor.csproj", "./"]
RUN dotnet restore "SchoolAppCoreRazor.csproj"
COPY . .
RUN dotnet publish "SchoolAppCoreRazor.csproj" -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:10.0-preview AS final
WORKDIR /app
EXPOSE 8080
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "SchoolAppCoreRazor.dll"]
