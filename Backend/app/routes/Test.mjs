import express from "express"; // Importing express for router creation

const testRoute = express(); // Creating a new instance of express router

testRoute.get("/", async (req, res) => {

    try {
        
        const message = `API WORKS`;
        
        return res.status(200).json({ message});
    } catch (error) {
        return res.status(500).json({ error: "Internal Server Error" });
    }
  });
  
  export { testRoute }; // Exporting the router for use in other files