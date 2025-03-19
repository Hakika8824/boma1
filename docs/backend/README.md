# Backend Implementation Guide

## Technology Stack

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB
- **Cache**: Redis
- **Search**: Elasticsearch
- **Authentication**: JWT + Passport
- **File Storage**: AWS S3/Digital Ocean Spaces
- **Email Service**: SendGrid
- **SMS Service**: Twilio/Africa's Talking
- **Payment Integration**: M-Pesa, Stripe

## Project Structure

```
backend/
├── src/
│   ├── config/            # Configuration files
│   ├── controllers/       # Route controllers
│   ├── middleware/        # Custom middleware
│   ├── models/           # Database models
│   ├── routes/           # API routes
│   ├── services/         # Business logic
│   ├── utils/            # Utility functions
│   └── validation/       # Request validation
├── tests/                # Test files
└── scripts/              # Utility scripts
```

## API Implementation

### 1. Authentication API

```typescript
// src/routes/auth.ts
import { Router } from 'express';
import { register, login, verify, resetPassword } from '../controllers/auth';

const router = Router();

router.post('/register', register);
router.post('/login', login);
router.post('/verify', verify);
router.post('/reset-password', resetPassword);

export default router;
```

### 2. Property API

```typescript
// src/routes/properties.ts
import { Router } from 'express';
import { 
  createProperty,
  getProperties,
  getProperty,
  updateProperty,
  deleteProperty
} from '../controllers/properties';

const router = Router();

router.post('/', createProperty);
router.get('/', getProperties);
router.get('/:id', getProperty);
router.put('/:id', updateProperty);
router.delete('/:id', deleteProperty);

export default router;
```

## Database Models

### 1. User Model

```typescript
// src/models/User.ts
import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  phone: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  userType: { type: String, enum: ['PROVIDER', 'CLIENT'] },
  verified: { type: Boolean, default: false },
  // ... other fields
});

export default mongoose.model('User', userSchema);
```

### 2. Property Model

```typescript
// src/models/Property.ts
import mongoose from 'mongoose';

const propertySchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  price: { type: Number, required: true },
  location: {
    type: { type: String, default: 'Point' },
    coordinates: [Number],
    address: String
  },
  // ... other fields
});

propertySchema.index({ location: '2dsphere' });

export default mongoose.model('Property', propertySchema);
```

## Security Implementation

### 1. Authentication Middleware

```typescript
// src/middleware/auth.ts
import jwt from 'jsonwebtoken';
import { Request, Response, NextFunction } from 'express';

export const authenticate = (req: Request, res: Response, next: NextFunction) => {
  // Implementation details...
};
```

### 2. Location Verification

```typescript
// src/services/location.ts
export const verifyLocation = async (coordinates: [number, number]) => {
  // Implementation details...
};
```

## External Service Integration

### 1. Payment Integration

```typescript
// src/services/payment.ts
export class PaymentService {
  async processMpesa(phone: string, amount: number) {
    // Implementation details...
  }

  async processStripe(token: string, amount: number) {
    // Implementation details...
  }
}
```

### 2. Notification Service

```typescript
// src/services/notification.ts
export class NotificationService {
  async sendSMS(phone: string, message: string) {
    // Implementation details...
  }

  async sendEmail(email: string, subject: string, content: string) {
    // Implementation details...
  }
}
```

## Error Handling

```typescript
// src/middleware/error.ts
export const errorHandler = (err: Error, req: Request, res: Response) => {
  // Implementation details...
};
```

## Testing Strategy

1. **Unit Tests**
   ```typescript
   // tests/unit/auth.test.ts
   describe('Auth Service', () => {
     it('should register new user', async () => {
       // Test implementation...
     });
   });
   ```

2. **Integration Tests**
   ```typescript
   // tests/integration/property.test.ts
   describe('Property API', () => {
     it('should create new property', async () => {
       // Test implementation...
     });
   });
   ```

## Deployment

1. **Environment Variables**
   ```bash
   NODE_ENV=production
   MONGODB_URI=mongodb://...
   JWT_SECRET=your-secret
   AWS_ACCESS_KEY=...
   AWS_SECRET_KEY=...
   ```

2. **Docker Configuration**
   ```dockerfile
   FROM node:16-alpine
   WORKDIR /app
   COPY package*.json ./
   RUN npm install
   COPY . .
   CMD ["npm", "start"]
   ```

## Monitoring and Logging

1. **Application Monitoring**
   ```typescript
   // src/config/monitoring.ts
   import winston from 'winston';
   
   export const logger = winston.createLogger({
     // Configuration details...
   });
   ```

2. **Performance Metrics**
   ```typescript
   // src/middleware/metrics.ts
   export const trackMetrics = (req: Request, res: Response, next: NextFunction) => {
     // Implementation details...
   };
   ```

## Development Guidelines

1. **Code Style**
   - Follow TypeScript best practices
   - Use ESLint and Prettier
   - Write comprehensive documentation

2. **Git Workflow**
   - Feature branches
   - Pull request reviews
   - Semantic versioning

3. **API Documentation**
   - Use Swagger/OpenAPI
   - Include request/response examples
   - Document error codes 