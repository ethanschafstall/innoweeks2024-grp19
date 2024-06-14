import { checkHash } from "../tools/hash.mjs";
import { generateToken } from "../tools/createToken.mjs";

// Endpoint for handling user login
export const postLogin = async(req, res) => {
  const { username, password, platform } = req.body;
  const findUserQueryString = `SELECT * FROM t_users WHERE useUsername = ?`;
  const updatePlatformQueryString = `UPDATE t_users SET usePlatform = ? WHERE useUsername = ?;`

     if (!username) {
        return res.status(401).json({ message: "You did not provide a username." });
    }
    if (!password) {
        return res.status(401).json({ message: "You did not provide a password." });
    }
    if (!platform) {
        return res.status(401).json({ message: "You did not provide a platform." });
    }

  try {
      const [result] = await req.dbConnection.execute(findUserQueryString, [username]);
      const user = result[0];

      if (!user) {
          return res.status(401).json({ message: "Invalid username or password." });
      }

      const salt = user.useSalt;
      const storedHash = user.usePassword;

      if (storedHash !== checkHash(salt, password)) {
          return res.status(401).json({ message: "Invalid username or password." });
      }
      await req.dbConnection.execute(updatePlatformQueryString, [platform, username]);
      const message = `User has successfully logged in.`;
      const token = generateToken(user);

      res.cookie('authToken', token, {
          httpOnly: true, // Accessible only by web server
          secure: true, // Ensures the cookie is only sent over HTTPS
          sameSite: 'strict', // Ensures the cookie is sent only to the same site
          maxAge: 24 * 60 * 60 * 1000, // Cookie expires in 24 hours
          path: '/'
      });
    
      return res.status(200).json({ message, token});
  } catch (error) {
      console.error("Error logging in:", error);
      return res.status(500).json({ error: "Internal Server Error" });
  }
};