const jwt = require('jsonwebtoken');

const testJWT = () => {
    const token = jwt.sign({ user_id: "12345" }, "my_super_secret_key", {
        expiresIn: '1h',
    });
    console.log("Generated JWT:", token);
};

testJWT();
