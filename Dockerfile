#first stage bse image

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR /source

COPY *.csproj  .
#get all dependincesfor all the project
RUN dotnet restore 


#copy and publish 
COPY . .
#to use in cloud  
RUN dotnet publish -c release -o /app

#multi staGE OF IMGES 
FROM mcr.microsoft.com/dotnet/aspnet:7.0

WORKDIR /app

COPY --from=build /app  .

ENTRYPOINT ["dotnet","hrapp.dll"]